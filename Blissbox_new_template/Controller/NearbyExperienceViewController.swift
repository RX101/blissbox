//
//  NearbyExperienceViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 28/12/17.
//  Copyright © 2017 ANG RUI XIAN . All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class NearbyExperienceViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var outMapView: MKMapView!
    
    // create a property for the location manager
    var locationManager = CLLocationManager()
    
    // create a property for the current location
    var currentLocation : CLLocation! = nil
    
    // create a property for the current annotation
    var pointAnnotation : MKPointAnnotation! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outMapView.mapType = .standard
        self.outMapView.setUserTrackingMode(.follow, animated: true)
        // show the location of the user on the map
        self.outMapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func panAndZoom(location : CLLocation) {
        // create a region centered around a given coordinate
        // the first parameter is the coordinate
        // the second parameter is the latitudinalMeters (north-south distance in meters)
        // the third parameter is the longitudinalMeters (east-west distance in meters)
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 200, 200)
        
        // set the display region
        self.outMapView.setRegion(region, animated: true)
    }
    
    func getDistance() -> CLLocationDistance {
        // ensure we have a current location
        // ensure we have an annotation
        guard let currentLocation = self.currentLocation,
            let point = self.pointAnnotation else {
                return 0
        }
        
        // get the annotation coordinates and make a CLLocation object
        let annotationCoordinate = point.coordinate
        let annotationLocation = CLLocation(latitude: annotationCoordinate.latitude,
                                            longitude: annotationCoordinate.longitude)
        
        // return the distance between the current location and the annotation
        return currentLocation.distance(from: annotationLocation)
    }
    
    // sets up the location manager and starts the standard location service
    fileprivate func setupLocationManager() {
        
        // it’s recommended that you always call the locationServicesEnabled class
        // method of CLLocationManager before attempting to start either the
        // standard or significant-change location services
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location services are disabled")
            return
        }
        
        // Create the location manager if it hasn't already been created
        if (locationManager == nil) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            // prompt for authorisation to use location services
            // will not prompt if already granted or rejected before
            print("yes")
            locationManager.requestWhenInUseAuthorization()
            
            // To use the standard location service, create an instance of the
            // CLLocationManager class and configure its desiredAccuracy and
            // distanceFilter properties
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            // Set a movement threshold for new events
            locationManager.distanceFilter = 500
            
            // To begin receiving location notifications, assign a delegate to the
            // object and call the startUpdatingLocation method
            locationManager.startUpdatingLocation()
        }
    }
    
    // This method is called when the application’s ability to use location services changes.
    // Changes can occur because the user allowed or denied the use of location services for
    // your application or for the system as a whole.
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            print("authorised")
            manager.startUpdatingLocation()
        } else {
            print("not authorised")
            manager.stopUpdatingLocation()
        }
    }
    
    // This method is called when it encounters an error trying to get the location or
    // heading data. If the user denies your application’s use of the location service,
    // this method reports a kCLErrorDenied error. Upon receiving such an error, you
    // should stop the location service.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        if error._code == CLError.denied.rawValue {
            print("didFailWithError denied")
            manager.stopUpdatingLocation()
        } else {
            print("didFailWithError \(error._code)")
        }
    }
    
    // This method is called when new location data is available
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // the locations array contains a list of updated locations
        // the last entry in the array is the latest location
        // do something with the updated location information
        if let loc = locations.last {
            print("coord:\(loc.coordinate), hacc:\(loc.horizontalAccuracy), time:\(loc.timestamp)")
            if (currentLocation == nil) {
                currentLocation = loc
                panAndZoom(location: loc)
                //                self.updateLabel()
            }
            
            // currentLocation has changed, update current location and center the map
            if ((currentLocation.coordinate.latitude != loc.coordinate.latitude)
                && (currentLocation.coordinate.longitude != loc.coordinate.longitude)) {
                currentLocation = loc
                panAndZoom(location: loc)
                //                self.updateLabel()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
