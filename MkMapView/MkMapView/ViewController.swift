//
//  ViewController.swift
//  MkMapView
//
//  Created by MacStudent on 2017-10-27.
//  Copyright © 2017 Dhruvi Patel. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate // Current Location
{

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    let myAnnotation: MKPointAnnotation = MKPointAnnotation()
    
    let initialLocation = CLLocation(latitude: 43.6532, longitude: -79.3832)
    let LambtonCollegeLocation = CLLocation(latitude: 43.773257, longitude: -79.335899)
    let CNTowerLocation = CLLocation(latitude: 43.642566, longitude: -79.387057)
    
    let regionRadius : CLLocationDistance = 4000
    /// 1000 = 1 km region
   
    // Current ?Location
    let locationManager = CLLocationManager()
 
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
        //mapView.mapType = MKMapType.satellite
        
        //centerMapOnLocation(location: LambtonCollegeLocation)
        setPointeAnnotation(Location: initialLocation, title: "City Hall", subTitle: "123, King Street")
        setPointeAnnotation(Location: LambtonCollegeLocation, title: "Lambton College", subTitle: "271 York Land bv")
        setPointeAnnotation(Location: CNTowerLocation, title: "Cn Tower", subTitle: "City center")
        
        //current location
        //getCurrentLocation()
    }

    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //to show points
    func setPointeAnnotation(Location : CLLocation, title: String, subTitle : String)
    {
        // Remove previous pointers
            //mapView.annotations.removeAll() // to remove all
        /*
        if( mapView.annotations.count != 0)
        {
            for i in 0..<mapView.annotations.count
            {
                var annotation = self.mapView.annotations[i]
                self.mapView.removeAnnotation(annotation)
            }
        }
        */
        
        
        // Drop a pin at user's Current Location
       
        myAnnotation.coordinate = CLLocationCoordinate2DMake(Location.coordinate.latitude, Location.coordinate.longitude);
        myAnnotation.title = title
        myAnnotation.subtitle = subTitle
        mapView.addAnnotation(myAnnotation)
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        // current location we get
        // now we can get the current location n use it to set the pointer
        
        //print(locations.description)
        let cuurentLatlog = locations[0] as! CLLocation
        setPointeAnnotation(Location: cuurentLatlog, title: "Current Location", subTitle: "local")
    }
    
    
    
    // current locaiton
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    //current location
    func getCurrentLocation()
    {
       // https://stackoverflow.com/questions/25296691/get-users-current-location-coordinates
        // Simulator -> debug -> Location -> Apple
        // Ask for Authorisation from the User.
        
        /* in plist
 
         <key>NSLocationAlwaysUsageDescription</key>
         <string>For Demo</string>
         
         <key>NSLocationWhenInUseUsageDescription</key>
         <string>For Demo</string>
         
         <!--    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>-->
         <!--    <string>Allow location usage</string>-->
 
 */
       
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        // For Continues updation of Current location
        /*
        DispatchQueue.main.async
        {
            self.locationManager.startUpdatingLocation()
        }
        */
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self as! CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @IBAction func segmentValueChange(_ sender: UISegmentedControl)
    {
        if(sender.selectedSegmentIndex == 0)
        {
            mapView.mapType = MKMapType.satellite
        }
        else if (sender.selectedSegmentIndex == 1)
        {
            mapView.mapType = MKMapType.standard
        }
        else
        {
            mapView.mapType = MKMapType.hybrid
        }
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

