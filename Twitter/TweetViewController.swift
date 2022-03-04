//
//  TweetViewController.swift
//  Twitter
//
//  Created by Brian Velecela on 2/28/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()  //keyboard will display
        tweetTextView.delegate = self
        
        
    }
    
    //our components and action
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    //cancel action
    @IBAction func cancelButton(_ sender: Any) {
        //with this cancel button, when we click on it, we went it to dismiss from that screen
        dismiss(animated: true, completion: nil)
    }
    //tweet button action
    @IBAction func tweet(_ sender: Any) {
        //check if the text view is empty
        if(!tweetTextView.text.isEmpty){
            //then we will call the API
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error)in
                print("Error posting tweet\(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //set the max character limit
        let characterLimit = 280
        
        //construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        //TODO: Upadte character count label
        //we will take our label and assign it
        counterLabel.text = "\(newText.count)/280"
        
        //the new text should be allowed? True/False
        return newText.count < characterLimit
        
    }
    
    
    
    
}
