//
//  signUp.swift
//  Where-You-At
//
//  Created by Apprentice on 11/20/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class signUp: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var firstname: UITextField!
    @IBOutlet var lastname: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func submit(sender: UIButton) {
        Alamofire.request(.POST, "http://localhost:3000/users", parameters: ["first_name": "\(firstname.text!)", "last_name": "\(lastname.text!)", "email": "\(username.text!)", "password": "\(password.text!)"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json["status"])
                        print("SUCCESS")
                        let id = json["id"].int!
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject(id, forKey: "id")
                        self.performSegueWithIdentifier("signUpToGroups", sender: self)
                    }
                default: break
                }
                
                
//                case .Failure(let error):
//                    print(error)
//                }
            }
        }


}