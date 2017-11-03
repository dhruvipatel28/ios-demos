//
//  ViewController.swift
//  2017F_MAD3115_FinalExam_Section_II
//
//  Created by moxDroid on 2017-11-02.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Roll No.    : C0719320
//  Name        : Dhruvi Patel

import UIKit

class PhoneCallViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btn_callNow(_ sender: UIButton)
    {
        if let url = URL(string: "tel://+6475684535)"), UIApplication.shared.canOpenURL(url)
        {
            if #available(iOS 10, *)
            {
                UIApplication.shared.open(url)
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }//if
    }
    
    @IBAction func btn_home(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

