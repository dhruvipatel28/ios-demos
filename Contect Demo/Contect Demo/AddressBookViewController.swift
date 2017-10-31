//
//  AddressBookViewController.swift
//  Contect Demo
//
//  Created by MacStudent on 2017-10-30.
//  Copyright © 2017 Dhruvi Patel. All rights reserved.
//

import UIKit
import AddressBook


class AddressBookViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedAddPetToContacts()
    {
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus
        {
            case .notDetermined:
               print("Not Determined")
            case .denied , .restricted:
               print("Denied")
            case .authorized:
                print("Authorized")
            default :
            print("default:")
        }
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
