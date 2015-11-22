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
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
