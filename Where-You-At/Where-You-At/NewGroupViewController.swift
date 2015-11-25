//
//  NewGroupViewController.swift
//  Where-You-At
//
//  Created by Apprentice on 11/22/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewGroupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var groupname: UITextField!
    @IBOutlet var event: UITextField!
    
    
    @IBAction func createGroup(sender: UIButton) {
        let ns = NSUserDefaults.standardUserDefaults()
        let id = ns.objectForKey("id")
        
        Alamofire.request(.POST, "http://whereyouat1.herokuapp.com/groups", parameters: ["name": "\(groupname.text!)", "event": "\(event.text!)", "id": "\(id!)"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json["status"])
                        print("SUCCESS")
                        self.performSegueWithIdentifier("createGroupToGroups", sender: self)
                    }
                default: break
                }
                
                
                //                case .Failure(let error):
                //                    print(error)
                //                }
        }
    }
    }
