//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Brian Velecela on 2/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

//this file is for the table view cell (we will configure it )
//make sure to connect this file to the tableview cell
class TweetCellTableViewCell: UITableViewCell {
    
    //connecting all element to code
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited: Bool = false //intial fav button to be false
    var tweetId:Int = -1
   
    //actions for fav and retweet button
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorite = !favorited
        if(toBeFavorite){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId , success: {
                self.setFavorite(true)
            }, failure:{(error) in
                print("Favorite did not succeed:\(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("unfavorite did not succeed:\(error)")
            })
        }
           
    }
    
    
    @IBAction func retweet(_ sender: Any) {
    }
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if favorited{   //if the intial is equal to the isFavorite
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)    //then we will change the icon
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
