//
//  LocationListViewController.swift
//  2017F_MAD3115_FinalExam_Section_II
//
//  Created by moxDroid on 2017-11-02.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Roll No.    : C0719320
//  Name        : Dhruvi Patel


// India Gate : 28.6129° N, 77.2295° E
//Qutb Minar  28.5244° N, 77.1855° E
/*
 The Red Fort  28.6562° N, 77.2410° E
 Humayun's Tomb  28.5933° N, 77.2507° E
 Taj Mahal : 27°10′30″N 78°02′31″E﻿ 
 */

import UIKit

class LocationListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    

    @IBOutlet weak var btn_phoneCall: UIButton!
    @IBOutlet weak var btn_email_sms: UIButton!
    @IBOutlet weak var tbl_location: UITableView!
    
    
    var AllLocation = [Location]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var indiaGate = Location()
        indiaGate.setLocation(1, "India Gate", 28.6129, 77.2295)
        AllLocation.append(indiaGate)
        
        print(Location.getLocation(AllLocation[0]))
        print("Location VC  -----:   " , AllLocation[0].locationTitle)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return AllLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "muCell", for: indexPath)
        cell.textLabel?.text = AllLocation[indexPath.row].locationTitle
        
        return cell
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}
