//
//  TweetViewController.swift
//  Twitter
//
//  Created by Brian Velecela on 2/28/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()  //keyboard will display
    }
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBAction func cancelButton(_ sender: Any) {
        //with this cancel button, when we click on it, we went it to dismiss from that screen
        dismiss(animated: true, completion: nil)
    }
    
     
    @IBAction func tweetButton(_ sender: Any) {
        //check if the text view is empty
        if(!tweetTextView.text.isEmpty){
            //then we will call the API
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: {(error)in
                print("Error posting tweet\(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    

   

}
