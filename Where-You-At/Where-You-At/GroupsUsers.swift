//
//  UserGroups.swift
//  Where-You-At
//
//  Created by Apprentice on 11/20/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

//import UIKit
//import SwiftyJSON
//import Alamofire
//
//class UserGroups: UIViewController {
//
//
//    @IBOutlet var groupName: UILabel!
//    
//    var outputMessage = String()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        groupName.text = outputMessage
//        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        
//        let url = "http://whereyouat1.herokuapp.com/users/1"
//        
//        Alamofire.request(.GET, url).validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    let json = JSON(value);
//                    
//                }
//                
//            case .Failure(let error):
//                print(error)
//            }
//        }
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//
//}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MATT'S UPDATED GROUPUSERS CODE

import UIKit
import Alamofire

class UserRepository {
    var email: String?
    var first_name: String?
    var last_name: String?
    var lat: Int?
    var lng: Int?
    
    init(json: NSDictionary){
        self.email = json["email"] as? String
        self.first_name = json["first_name"] as? String
        self.last_name = json["last_name"] as? String
        self.lat = json["lat"] as? Int
        self.lng = json["lng"] as? Int
    }
}


class UserGroups: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var groupName: UILabel!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var outputMessage = String()
    
    var currentGroup = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupName.text = "\(outputMessage)"
        print("**********************")
        print("THIS IS THE OUTPUT MESSAGE \(groupName.text)")
        print("***********************")
        //        if groupName != nil {
        //            groupName.text = outputMessage
        //        }
        //
        currentGroup = outputMessage
        
        //        table.delegate = self
//                table.dataSource = self
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let url = NSURL(string: "http://whereyouat1.herokuapp.com/groups/\(outputMessage)")
        
        
        
        if let JSONData = NSData(contentsOfURL: url!) {
            if let json = try! NSJSONSerialization.JSONObjectWithData(JSONData, options: []) as? NSDictionary {
                
                if let reposArray = json["users"] as? [NSDictionary]{
                    for first_name in reposArray {
                        repositories.append(UserRepository(json: first_name))
                    }
                }
            }
        }
    }
    
    var repositories = [UserRepository]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        var groupLabel = cell.textLabel?.text = repositories[indexPath.row].first_name
        cell.detailTextLabel?.text = repositories[indexPath.row].first_name
        print(currentGroup)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedRow = tableView.cellForRowAtIndexPath(indexPath)!
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject?) {
//        let thirdController:MapViewController = segue.destinationViewController as! MapViewController
//        thirdController.object = currentGroup
//    }
    
    
}

