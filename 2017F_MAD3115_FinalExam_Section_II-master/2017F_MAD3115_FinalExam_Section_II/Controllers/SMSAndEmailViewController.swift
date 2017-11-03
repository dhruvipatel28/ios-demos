//
//  SendEmailViewController.swift
//  2017F_MAD3115_FinalExam_Section_II
//
//  Created by moxDroid on 2017-11-02.
//  Copyright © 2017 moxDroid. All rights reserved.
//  Roll No.    : C0719320
//  Name        : Dhruvi Patel


import UIKit
import MessageUI


class SMSAndEmailViewController: UIViewController, MFMessageComposeViewControllerDelegate
{
    
    @IBOutlet weak var lbl_subject: UITextField!
    @IBOutlet weak var lbl_bodyOfMail: UITextView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btn_sendSms(_ sender: UIButton)
    {
        if MFMessageComposeViewController.canSendText()
        {
            let messageVC = MFMessageComposeViewController()
            messageVC.body = "Hello, How are you?"
            messageVC.recipients = ["+6475684535"]
            messageVC.messageComposeDelegate = self
            self.present(messageVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func btn_home(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func btn_email(_ sender: UIButton)
    {
        if MFMailComposeViewController.canSendMail()
        {
            let MailVC = MFMailComposeViewController()
            MailVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            MailVC.setCcRecipients(["dhruvipatel282@gmail.com"])
            MailVC.setSubject(lbl_subject.text!)
            MailVC.setMessageBody(lbl_bodyOfMail.text!, isHTML: true)
            present(MailVC, animated: true, completion: nil)
        }
    }
    
   func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        switch (result)
        {
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
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
