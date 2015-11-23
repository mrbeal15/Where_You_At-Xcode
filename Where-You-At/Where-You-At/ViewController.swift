//
//  ViewController.swift
//  Where-You-At
//
//  Created by Apprentice on 11/19/15.
//  Copyright (c) 2015 Apprentice. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults() != 0 {
            performSegueWithIdentifier("toGroups", sender: self)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   


//    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
//        if identifier == "segueTest" {
//            let ns = NSUserDefaults.standardUserDefaults()
//            var id = ns.objectForKey("id")
//            if id == nil {
//                
////                let alert = UIAlertView()
////                alert.title = "No Text"
////                alert.message = "Please Enter Text In The Box"
////                alert.addButtonWithTitle("Ok")
////                alert.show()
//                
//                return false
//            }
//                
//            else {
//                return true
//            }
//        }
//        
//        // by default, transition
//        return true
//    }
    
    

    

    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!

    @IBAction func signIn(sender: UIButton) {
        Alamofire.request(.POST, "http://localhost:3000/login",parameters: ["email" : "\(username.text!)", "password" : "\(password.text!)"], encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json["status"])
                        print("true")
                        let id = json["id"].int!
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject(id, forKey: "id")
                        self.performSegueWithIdentifier("toGroups", sender: self)
                    }
                    
                case .Failure(let error):
                    print("You Didn't Log In")
                    let alert = UIAlertView()
                    alert.title = "Invalid Credentials"
                    alert.message = "Sorry, this username and password do not match"
                    alert.addButtonWithTitle("Ok")
                    alert.show()
        
                }
                
        }
    }

}