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
    
    var groupName = String()
    var currentGroup = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGroup = groupName
        
        print("************URL******************")
        print("http://whereyouat1.herokuapp.com/groups/\(currentGroup)/invite")
        print("*********************************")
        // Do any additional setup after loading the view.
        
    
    }

    @IBOutlet var invite: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGroupMember(sender: UIButton) {
        Alamofire.request(.POST, "http://whereyouat1.herokuapp.com/groups/\(currentGroup)/invite", parameters: ["email": "\(self.invite.text!)"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json)
                        self.performSegueWithIdentifier("addGroupMember", sender: self)
                    }
                case .Failure(let error):
                    print(error)
                }
        }
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
