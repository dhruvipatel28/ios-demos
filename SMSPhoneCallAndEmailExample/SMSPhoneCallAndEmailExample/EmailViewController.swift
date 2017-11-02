//
//  EmailViewController.swift
//  SMSPhoneCallAndEmailExample
//
//  Created by moxDroid on 2017-10-26.
//  Copyright © 2017 moxDroid. All rights reserved.
//  https://www.hackingwithswift.com/example-code/uikit/how-to-send-an-email
//  https://www.andrewcbancroft.com/2014/08/25/send-email-in-app-using-mfmailcomposeviewcontroller-with-swift/
//  https://stackoverflow.com/questions/40887721/sending-an-email-from-swift-3


import UIKit
import MessageUI

class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {
   
    @IBOutlet var subject: UITextField!
    @IBOutlet var body: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func sendMail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
        
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject(subject.text!)
        picker.setMessageBody(body.text!, isHTML: true)
        
        present(picker, animated: true, completion: nil)
        }
    }
    
    // MFMailComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
}
