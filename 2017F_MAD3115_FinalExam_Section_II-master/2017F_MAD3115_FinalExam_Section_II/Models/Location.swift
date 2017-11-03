//
//  Location.swift
//  2017F_MAD3115_FinalExam_Section_II
//
//  Created by moxDroid on 2017-11-02.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Roll No.    : C0719320
//  Name        : Dhruvi Patel

import Foundation
class Location
{
    var locationId : Int!
    var locationTitle : String!
    var Latitude : Double!
    var Longitude : Double!
    
    init()
    {
        self.locationId = 0
        self.locationTitle = " "
        self.Latitude = 0.0
        self.Longitude = 0.0
    }
    
    func setLocation(_ id : Int , _ title : String , _ lat  : Double , _ long : Double)
    {
        self.locationId = id
        self.locationTitle = title
        self.Latitude = lat
        self.Longitude = long
    }
    
    func getLocation(loc : Location)
    {
        print("id : \(loc.locationId)  ----   Title : \(loc.locationTitle)")
        print("lat : \(loc.Latitude)  ----   Long : \(loc.Longitude)")
    }
    
    
    
}
