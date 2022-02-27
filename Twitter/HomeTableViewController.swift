//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Brian Velecela on 2/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // we will create a local container
    // var = never changes
    // let = can be change
    var tweetArray = [NSDictionary]()   //array of dict.
    var numberOfTweet: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweet() // when the view load, run this func
    }
    
    func loadTweet(){
        let myUrl  = "https://api.twitter.com/1.1/statuses/home_timelin.json"    //home_timeline url
        let myParms = ["count": 10]  //parameters
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParms, success: { [self]
            //Results of tweets
            (tweets: [NSDictionary]) in
            
            //before appending, we should clean up array
            self.tweetArray.removeAll()      //empty entire array
            
            //"for every single tweet from the created tweets
            for tweet in tweets{
                //"for every tweet i get from the list of tweets, i want it to add those tweet to my array"
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
                    
        }, failure:{ (Error) in
            print("could not retreive tweets! oh no!!")

        })
        
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
        let imageUrl = URL(string: (user?["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
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

   

}
