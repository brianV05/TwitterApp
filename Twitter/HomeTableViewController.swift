//
//  HomeTableViewController.swiftzA
//  Twitter
//
//  Created by Brian Velecela on 2/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController{
    
    // we will create a local container
    // var = never changes
    // let = can be change
    var tweetArray = [NSDictionary]()   //array of dict.
    var numberOfTweet: Int!
    let myRefreshControl = UIRefreshControl()   //UIRefreshVControl
    
    override func viewDidLoad() {  //viewDidLoad repeats only ONE time
        super.viewDidLoad()
        //addtarget what kind of action, you want to tie to this refresh control
        //self = same screen  ,   action: reload the loadtweet func   ,   for: '''
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        //telling the table which refresh control to use
        tableView.refreshControl = myRefreshControl
        tableView.rowHeight = UITableView.automaticDimension // this is to have a fixed table view cell
        tableView.estimatedRowHeight = 150
        print("ViewDidLoad was called")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweet()
        print("ViewDidAppear was called")
    }
    
    @objc func loadTweet(){
        numberOfTweet = 20
        
        let myUrl  = "https://api.twitter.com/1.1/statuses/home_timeline.json"  //home_timeline url
        let myParms = ["count": numberOfTweet]  //parameters
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParms, success:
        {(tweets: [NSDictionary]) in   //Results of tweets
            
            //before appending, we should clean up array
            self.tweetArray.removeAll()      //empty entire array
            //"for every single tweet from the created tweets
            for tweet in tweets{
                //"for every tweet i get from the list of tweets, i want it to add those tweet to my array"
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()  // this is: to stop the loading on top to go away
                    
        }, failure:{ (Error) in
            print("could not retreive tweets! oh no!!")
        })
    }
    
    //infinite scroll
    func loadMoreTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        //we will be adding 10 more tweets to the original
        numberOfTweet = numberOfTweet + 10
        let myParms = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParms, success:
        {(tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure:{ (Error) in
            print("could not retreive tweets! oh no!!")
        })
    }
    
    //this is a func when the user scrolls and get to the end of the table
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{   //"when the user get to the end of the page
            loadMoreTweets()        // run more tweets
        }
    }
    
        //logout button
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()    // this will log out in the background
        
        //"I'm going to dismiss myself"
        self.dismiss(animated: true, completion: nil) // this will log out and return to login screen
        
        //when using the UserDefault key, we want it to be the same as the previous.
        // becuase that is the exact key the app will check if the user is still logged in
        //THIS LINE: when the logout button is clicked on, it will return to the login screen.
        //if you close the app as well, it will launch you to the login screen b/c no UserDefault value found 
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // we set it to type TweetCellTableViewCell to do the following :(its grabbing the variable from TweetCellTableViewCell to this file
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        //for the name
        //extract the user becuase the value "name" is in the value "user"
        let user = tweetArray[indexPath.row]["user"] as? NSDictionary
        cell.userNameLabel.text = user?["name"] as? String
        
        //for the content
        cell.tweetContentLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        //for the image profile
        let imageUrl = URL(string: (user!["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        //check if its favorited or not
        //this is part of the retweet and fav section 
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find the selected cell
        let cell = sender as! UITableViewCell
        
        //pass the selected cell to the profile details
        let indexPath = tableView.indexPath(for: cell)!
        
        let tweetArray = tweetArray[indexPath.row]
        let profileViewController = segue.destination as! profileViewController
        profileViewController.tweetArray = [tweetArray]
    }
    
   
    
    

}
