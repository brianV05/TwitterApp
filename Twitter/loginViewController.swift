//
//  loginViewController.swift
//  Twitter
//
//  Created by Brian Velecela on 2/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //user stays logged in across restarts
    override func viewDidAppear(_ animated: Bool) {
        //checking for UserDefault value
        //this is when i close the app and reopen the app, it will remember im still logged in and display me in the home page
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginToHome", sender: self) // once system find UserDefault value, it will automtically perform a segue way.
        }
    }
    
    
    @IBAction func onLoginButton(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"
        
        //we will add UserDefaults to remember user login
        //for value:" when the user is logged in, we will say true"
        //for forKey: "what is the name of this value ^"
        UserDefaults.standard.set(true, forKey: "userLoggedIn")
        //"tell me which url you want me to call, tell me what you what me to do when it works and tell me when it doesn't
        TwitterAPICaller.client?.login(url: myUrl, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Couldn't log in")
        })
        
    }
    
    

    
}
