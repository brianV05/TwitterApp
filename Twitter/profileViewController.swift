//
//  profileViewController.swift
//  Twitter
//
//  Created by Brian Velecela on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
    var tweetArray: [NSDictionary]!  // dict
    //let user = tweetArray["user"]

    
    @IBOutlet weak var tweetLabel: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameLabel.text = tweetArray(user["name"]) as? String
        
       
 
    }
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
