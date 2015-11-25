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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reposURL = NSURL(string: "https://api.github.com/search/repositories?q=learn+swift+language:swift&sort=stars&order=desc")
        
        if let JSONData = NSData(contentsOfURL: reposURL!) {
            if let json = try! NSJSONSerialization.JSONObjectWithData(JSONData, options: []) as? NSDictionary {
                if let reposArray = json["items"] as? [NSDictionary]
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
    
    @IBAction func performSequeWithIdentifier(sender: UIButton) {
        
    }
    
    @IBAction func logout(sender: UIButton) {
//        let id = 3
//        NSUserDefaults.standardUserDefaults().setObject(id, forKey: "")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("")

        let defaults = NSUserDefaults.standardUserDefaults()

        print(defaults.dictionaryRepresentation())
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GroupName", forIndexPath: indexPath) as! UITableViewCell
        var groupLabel = cell.textLabel?.text = repositories[indexPath.row].name
        cell.detailTextLabel?.text = repositories[indexPath.row].description
        func openGroup(sender: UIButton!) {
            func performSegueWithIdentifier(sender: UIButton!){};
        }
        
        return cell
        
        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            var secondViewController:UserGroups = segue.destinationViewController as! UserGroups
            //this is where we'll need to send 
        }
    }
   

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedRow = tableView.cellForRowAtIndexPath(indexPath)!
        
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
