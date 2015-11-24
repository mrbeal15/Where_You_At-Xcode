//
//  Invite.swift
//  Where-You-At
//
//  Created by Apprentice on 11/20/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Invite: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var invite: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGroupMember(sender: UIButton) {
        print("=========================================")
        
        Alamofire.request(.GET, "http://whereyouat1.herokuapp.com/users", parameters: ["email": "\(invite.text!)"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json)
                        print("*******SUCCESS*******")
                    }
                    
                case .Failure(let error):
                    print("GET DIDN'T QUITE WORK YET")
                    print(error)
                }
            }
        
        Alamofire.request(.POST, "http://whereyouat1.herokuapp.com/groups/1/invite", parameters: ["email": "\(self.invite.text!)", "group_id": 1, "user_id": 11])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json["status"])
                        print("SUCCESS")
//                       not sure what to do here.  somehow add the member to the group
                        self.performSegueWithIdentifier("addGroupMember", sender: self)
                        
                    }
                case .Failure(let error):
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                    print(error)
                }
            }
    }

    

    
}
