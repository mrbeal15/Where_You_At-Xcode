//
//  UserGroups.swift
//  Where-You-At
//
//  Created by Apprentice on 11/20/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

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

        
        
        // Do any additional setup after loading the view.
        
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

    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject?) {
        let thirdController:MapViewController = segue.destinationViewController as! MapViewController
        thirdController.object = currentGroup
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



























