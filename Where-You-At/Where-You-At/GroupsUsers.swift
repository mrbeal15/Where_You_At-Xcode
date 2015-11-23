//
//  userGroups.swift
//  Where-You-At
//
//  Created by Apprentice on 11/20/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class repository {
    
    var name: String?
    var description: Int?
    var html_url: String?
    
    init(json: NSDictionary) {
        self.name = json["name"] as? String
        self.description = json["description"] as? Int
        self.html_url = json["html_url"] as? String
    }
}

class userGroups: UIViewController {

    @IBOutlet var users: UITableViewCell!
    
    @IBOutlet var table: UITableView!

    @IBOutlet var groupName: UILabel!
    
    var outputMessage = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("*****************************")
        print(outputMessage)
        print("*************************")
        groupName.text = outputMessage
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let url = NSURL(string: "https://api.github.com/search/repositories?q=learn+swift+language:swift&sort=stars&order=desc")
        
        if let JSONData = NSData(contentsOfURL: url!) {
            if let json = try! NSJSONSerialization.JSONObjectWithData(JSONData, options: []) as? NSDictionary {
                if let reposArray = json["items"] as? [NSDictionary]{
                    for item in reposArray {
                        repositories.append(Repository(json: item))
                    }
                }
            }
        }

        
        

        
        
        
        
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
        
    }
    
    var repositories = [Repository]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GroupName", forIndexPath:  indexPath) as! UITableViewCell
        var groupLabel = cell.textLabel?.text = repositories[indexPath.row].name
        cell.detailTextLabel?.text = repositories[indexPath.row].description
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedRow = tableView.cellForRowAtIndexPath(indexPath)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
