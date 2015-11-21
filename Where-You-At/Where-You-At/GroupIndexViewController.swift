//
//  GroupIndexViewController.swift
//  Where-You-At
//
//  Created by Apprentice on 11/21/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import Alamofire

class GroupIndexViewController: UIViewController, UITableViewDataSource {


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
///////////////
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let url = "http://whereyouat1.herokuapp.com/users/1"
//        
//       
//        Alamofire.request(.GET, url).validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value{
//                    for name in value {
//                        repositories.append(Repository(json: item))
//                    }
//                }
//            case .Failure(let error):
//                print(error)
//            }
//        }
    
    
        let reposURL = NSURL(string: "http://localhost:3000/users/1")
        print("***************************")
        print(reposURL)
        
        if let JSONData = NSData(contentsOfURL: reposURL!) {
            if let json = try! NSJSONSerialization.JSONObjectWithData(JSONData, options: []) as? NSDictionary {
                
            }
        }
        
        if let JSONData = NSData(contentsOfURL: reposURL!) {
            if let json = try! NSJSONSerialization.JSONObjectWithData(JSONData, options: []) as? NSDictionary {
                if let reposArray = json["groups"] as? [NSDictionary] {
                    for item in reposArray {
                        repositories.append(Repository(json: item))
                    }
                }
            }
        }
    }
    
    
    
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
    
    
    var repositories = [Repository]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GroupName", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = repositories[indexPath.row].name
        cell.detailTextLabel?.text = repositories[indexPath.row].description
        return cell
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
