//
//  ShowLocationOnMapViewController.swift
//  2017F_MAD3115_FinalExam_Section_II
//
//  Created by moxDroid on 2017-11-02.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Roll No.    : C0719320
//  Name        : Dhruvi Patel

import UIKit
import MapKit


class ShowLocationOnMapViewController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    
    let myAnnotation: MKPointAnnotation = MKPointAnnotation()
    let regionRadius : CLLocationDistance = 1000
    
    //let initialLocation = CLLocation(latitude: 43.6532, longitude: -79.3832)
    
    var loc_lat : CLLocationDegrees = 43.6532
    var loc_long : CLLocationDegrees = -79.3832
    var loc_title : String = "Title"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
        mapView.mapType = MKMapType.standard
        
        print(self.loc_lat)
        print(self.loc_long)
        print(self.loc_title)
        let initialLocation = CLLocation(latitude: loc_lat, longitude: loc_long)
        
        centerMapOnLocation(location: initialLocation)
        setPointeAnnotation(Location: initialLocation, title: loc_title, subTitle: "123, King Street")
    }

    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func setPointeAnnotation(Location : CLLocation, title: String, subTitle : String)
    {
        // Remove previous pointers
        //mapView.annotations.removeAll() // to remove all
        myAnnotation.coordinate = CLLocationCoordinate2DMake(Location.coordinate.latitude, Location.coordinate.longitude);
        myAnnotation.title = title
        //myAnnotation.subtitle = subTitle
        mapView.addAnnotation(myAnnotation)
    }
    
    
    @IBAction func btn_home(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
