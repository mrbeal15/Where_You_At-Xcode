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
    
    
    @IBOutlet weak var mapkit: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mapkit.showsUserLocation = true
        
    }

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
        
        let url = "http://whereyouat1.herokuapp.com/groups/1"
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    
                    for (_, location):(String, JSON) in json {
                        print(location)
                        let name = location["first_name"].stringValue, lat = Float(location["lat"].stringValue), lng = Float(location["lng"].stringValue)
                        let pin = CustomPin(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lng!)), title: name, subtitle: "Where you at!")
                        self.mapkit.addAnnotation(pin)
                        self.mapkit.centerCoordinate = pin.coordinate
                        
                        func startMonitoringSignificantLocationChanges(){
                            self.mapkit.addAnnotation(pin)
                        }
                    }
                }
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    func startUpdatingLocation(){
        print("Updating...")
    };
    
    
    
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
