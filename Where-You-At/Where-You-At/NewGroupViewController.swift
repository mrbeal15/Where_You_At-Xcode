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
        
        Alamofire.request(.POST, "http://localhost:3000/groups", parameters: ["name": "\(groupname.text!)", "event": "\(event.text!)", "id": "\(id!)"])
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
