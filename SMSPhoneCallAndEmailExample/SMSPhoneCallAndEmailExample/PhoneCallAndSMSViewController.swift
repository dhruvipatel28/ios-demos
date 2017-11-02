//
//  ViewController.swift
//  SMSPhoneCallAndEmailExample
//
//  Created by moxDroid on 2017-10-26.
//  Copyright © 2017 moxDroid. All rights reserved.
//

import UIKit
import MessageUI

class PhoneCallAndSMSViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Send SMS
    @IBAction func sendMessage(sender: UIButton) {
        
        if MFMessageComposeViewController.canSendText() {
            
        
            let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "Hello, How are you?"
        messageVC.recipients = ["+11234567890"]
        messageVC.messageComposeDelegate = self
        
        self.present(messageVC, animated: false, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        
    switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    ///Make Phone Call
    @IBAction func makePhoneCall(sender: UIButton)
    {
        if let url = URL(string: "tel://+1123777777)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *)
            {
                UIApplication.shared.open(url)
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}

