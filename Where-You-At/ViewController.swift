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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!

    @IBAction func signIn(sender: UIButton) {
        Alamofire.request(.POST, "http://localhost:3000/login",parameters: ["email" : "\(username.text!)", "password" : "\(password.text!)"], encoding: .JSON)
            .responseJSON { response in debugPrint(response)}
    }

}

