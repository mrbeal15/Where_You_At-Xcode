//
//  signUp.swift
//  Where-You-At
//
//  Created by Apprentice on 11/20/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class signUp: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var fullname: UITextField!

    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!

    
    @IBAction func submit(sender: UIButton) {
        Alamofire.request(.POST, "http://localhost:3000/users", parameters: ["first_name": "\(fullname.text!)", "email": "\(username.text!)", "password": "\(password.text!)"])
    }


    
}