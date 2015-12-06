//
//  GroupIndexViewController.swift
//  Where-You-At
//
//  Created by Apprentice on 11/21/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import Alamofire


class Repository {
    
    var name: String?
    var description: String?
    var html_url: String?
    
    
    init(json: NSDictionary) {
        self.name = json["name"] as? String
        self.description = json["description"] as? String
        self.html_url = json["html_url"] as? String
    }
}

class GroupIndexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    var cell = UITableViewCell()
    var objectName = String()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let ns = NSUserDefaults.standardUserDefaults()
        let id = ns.objectForKey("id")!
        
        print("************!!!**********")
                print(id)
        print("************!!!**********")
        
        let reposURL = NSURL(string: "https://whereyouat1.herokuapp.com/users/\(id)")
        
        if let JSONData = NSData(contentsOfURL: reposURL!) {
            if let json = try! NSJSONSerialization.JSONObjectWithData(JSONData, options: []) as? NSDictionary {
                
                if let reposArray = json["groups"] as? [NSDictionary]
                {
                    for item in reposArray {
                        repositories.append(Repository(json: item))
                    }
                }
            }
        }
    }
    
    var repositories = [Repository]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    

    
    
    @IBAction func logout(sender: UIButton) {

        NSUserDefaults.standardUserDefaults().removeObjectForKey("")

        let defaults = NSUserDefaults.standardUserDefaults()

        print(defaults.dictionaryRepresentation())
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("GroupName", forIndexPath: indexPath)
        var groupLabel = cell.textLabel?.text = repositories[indexPath.row].name
        cell.detailTextLabel?.text = repositories[indexPath.row].name
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        objectName = tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text!
        performSegueWithIdentifier("userGroups", sender: indexPath)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject?) {
        if (segue.identifier == "userGroups") {
        let secondViewController:UserGroups = segue.destinationViewController as! UserGroups
        secondViewController.outputMessage = objectName
        }
    }
    
    
    

////////////
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
