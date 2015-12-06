//
//  MapViewController.swift
//  Where-You-At
//
//  Created by Apprentice on 11/20/15.
//  Copyright © 2015 Apprentice. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation
import MapKit
import Foundation

class CustomPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var object = String()
    
    @IBOutlet weak var mapkit: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization() //.requestWhenInUseAuthorization
        
        self.locationManager.startUpdatingLocation()
        
        self.mapkit.showsUserLocation = true
        
        
        self.timer()
//        self.timer2()
        
        Alamofire.request(.GET, "http://whereyouat1.herokuapp.com/groups/\(object)").validate().responseJSON { response in
            switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let users = json["users"]
                    
                    print("_____________________")
                    print(users)
                    print("_____________________")
                    
                    for (_, user):(String, JSON) in users {
                        let name = user["first_name"].stringValue, lat = Float(user["lat"].stringValue), lng = Float(user["lng"].stringValue)
                        
                        let pin = CustomPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lng!)), title: name, subtitle: "Where you at!")
                        self.mapkit.addAnnotation(pin)
                        self.mapkit.centerCoordinate = pin.coordinate
                        
                    }
                }
                
            case .Failure(let error):
                print(error)
            }
            print(CLLocationCoordinate2D(latitude: self.location.coordinate.latitude, longitude: self.location.coordinate.longitude))
        }
    }
    
    var location = CLLocation()
    
    func sendCoord() {
        let ns = NSUserDefaults.standardUserDefaults()
        let id = ns.objectForKey("id")
        
        let userLocation = mapkit.userLocation
    
        print(">>>>>>>>>>>>>>>>>\(userLocation.coordinate.latitude)<<<<<<<<<")
        print(">>>>>>>>>>>>>>>>>\(id!)<<<<<<<<<")
        Alamofire.request(.POST, "http://whereyouat1.herokuapp.com/users/\(id!)/coordinates", parameters: ["coord": ["lat":"\(userLocation.coordinate.latitude)", "lng":"\(userLocation.coordinate.longitude)"]])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value{
                        let json = JSON(value)
                        print(json["status"])
                    }
                
                case .Failure(let error):
                    print(error)
                }
        }
        
        
        
        Alamofire.request(.GET, "http://whereyouat1.herokuapp.com/groups/\(object)").validate().responseJSON { response in
            switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    let json = JSON(value)
                   
                    let users = json["users"]
                    
                    print("_____________________")
                    print(users)
                    print("_____________________")
                    
                    let annotationsToRemove = self.mapkit.annotations.filter { $0 !== self.mapkit.userLocation }
                    self.mapkit.removeAnnotations( annotationsToRemove )
                    
                    for (_, user):(String, JSON) in users {
                        let name = user["first_name"].stringValue, lat = Float(user["lat"].stringValue), lng = Float(user["lng"].stringValue)
                        
                        let pin = CustomPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lng!)), title: name, subtitle: "Where you at!")
                        self.mapkit.addAnnotation(pin)
                        self.mapkit.centerCoordinate = pin.coordinate
                        
                    }
                }
                
            case .Failure(let error):
                print(error)
            }
            print(CLLocationCoordinate2D(latitude: self.location.coordinate.latitude, longitude: self.location.coordinate.longitude))
        }

        
    }
    
    func timer() {
        let timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "sendCoord", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
//        self.mapkit.removeAnnotations(self.mapkit.annotations)
    }
    
    
//    func timer2() {
//        let timer2 = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "locationManager", userInfo: nil, repeats: true)
//        NSRunLoop.currentRunLoop().addTimer(timer2, forMode: NSRunLoopCommonModes)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let location = locations.last
            
            let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            
            self.mapkit.setRegion(region, animated: true)
            
            self.locationManager.stopUpdatingLocation()

            let url = "http://whereyouat1.herokuapp.com/groups/\(object)"
            
//            Alamofire.request(.GET, url).validate().responseJSON { response in
//                switch response.result {
//                case .Success:
//                    
//                    if let value = response.result.value {
//                        let json = JSON(value)
//                        let users = json["users"]
//                        for (_, user):(String, JSON) in users {
//                            
//                            let name = user["first_name"].stringValue, lat = Float(user["lat"].stringValue), lng = Float(user["lng"].stringValue)
//
//                            let pin = CustomPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lng!)), title: name, subtitle: "Where you at!")
//                            self.mapkit.addAnnotation(pin)
//                            self.mapkit.centerCoordinate = pin.coordinate
//                            
//                        }
//                    }
//                    
//                case .Failure(let error):
//                    print(error)
//                }
//            }
//            print(center)
        }

    
    func locationmanager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if case .AuthorizedWhenInUse = status {
            if #available(iOS 9.0, *) {
                manager.requestLocation()
            } else {
                // Fallback on earlier versions
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
