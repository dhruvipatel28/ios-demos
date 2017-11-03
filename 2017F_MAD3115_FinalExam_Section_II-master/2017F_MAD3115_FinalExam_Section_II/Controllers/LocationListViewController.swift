//
//  LocationListViewController.swift
//  2017F_MAD3115_FinalExam_Section_II
//
//  Created by moxDroid on 2017-11-02.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Roll No.    : C0719320
//  Name        : Dhruvi Patel

/*
// India Gate : 28.6129° N, 77.2295° E
// https://www.google.ca/maps/place/India+Gate/@28.612912,77.2295097,15z/data=!4m5!3m4!1s0x0:0x717971125923e5d!8m2!3d28.612912!4d77.2295097


//Qutb Minar  28.5244° N, 77.1855° E
https://www.google.ca/maps/place/Qutub+Minar/@28.5244281,77.1854559,15z/data=!4m2!3m1!1s0x0:0x834995f160759db8?sa=X&ved=0ahUKEwiuzY6km6HXAhXK34MKHW2tBw0Q_BIIfjAP
 
 The Red Fort  28.6562° N, 77.2410° E
 https://www.google.ca/maps/place/Red+Fort/@28.6561592,77.2410203,15z/data=!4m5!3m4!1s0x0:0x441e32f4fa5002fb!8m2!3d28.6561592!4d77.2410203
 
 Humayun's Tomb  28.5933° N, 77.2507° E
 https://www.google.ca/maps/place/Humayun's+Tomb/@28.5932818,77.2507488,15z/data=!4m5!3m4!1s0x0:0x938663ce3e1f68f7!8m2!3d28.5932818!4d77.2507488
 
 
 Taj Mahal : 27°10′30″N 78°02′31″E﻿
 https://www.google.ca/maps/place/Taj+Mahal/@27.1750151,78.0421552,15z/data=!4m5!3m4!1s0x0:0xdd2ae4803f767dde!8m2!3d27.1750151!4d78.0421552
 
 */

import UIKit
import MapKit

class LocationListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
   
    @IBOutlet weak var tbl_location: UITableView!
    
    var AllLocation = [Location]()
    var locationObj = Location()
    
     override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tbl_location.delegate = self
        self.tbl_location.dataSource = self
        setAllLocations()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return AllLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = AllLocation[indexPath.row].locationTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let lat = Float(AllLocation[indexPath.row].Latitude)
        let long = Float(AllLocation[indexPath.row].Longitude)
        
        print(AllLocation[indexPath.row].locationTitle)
        print(CLLocationDegrees(lat!))
        print(CLLocationDegrees(long!))
        
        let nextScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowLocationOnMapViewController") as! ShowLocationOnMapViewController
        nextScreen.loc_lat = CLLocationDegrees(lat!)
        nextScreen.loc_long = CLLocationDegrees(long!)
        nextScreen.loc_title = AllLocation[indexPath.row].locationTitle
        
        self.present(nextScreen, animated: true, completion: nil)
         
    }
    
    func setAllLocations()
    {
        locationObj.setLocation(1, "India Gate", "28.6129", "77.2295")
        AllLocation.append(locationObj)
        locationObj = Location()
        locationObj.setLocation(2, "Qutb Minar", "28.5244", "77.1855")
        AllLocation.append(locationObj)
        locationObj = Location()
        locationObj.setLocation(3, "The Red Fort", "28.6562", "77.2410")
        AllLocation.append(locationObj)
        locationObj = Location()
        locationObj.setLocation(3, "Humayun's Tomb", "28.5933", "77.2507")
        AllLocation.append(locationObj)
        locationObj = Location()
        locationObj.setLocation(3, "Taj Mahal", "27.1750", "78.0422")
        AllLocation.append(locationObj)
        
        //print("Location VC  -----:   " , AllLocation[0].locationId)
    }
    
    @IBAction func btn_quit(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
        exit(0)

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}
