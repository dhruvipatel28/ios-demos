//
//  information_viewControllerViewController.swift
//  Final Project
//
//  Created by MacStudent on 2017-10-27.
//  Copyright © 2017 Dhruv Patel. All rights reserved.
//

import UIKit

class information_viewControllerViewController: UIViewController
{

    @IBOutlet weak var webView: UIWebView!
 
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadMyHeml()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func btn_close(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadFromString()
    {
        webView.loadHTMLString("<htlm><body> <h1> Welcome </h1> </body></html>", baseURL: nil)
        loadMyHeml()
    }
    
    func loadFromURl()
    {
        let url = URL(string: "https://makeapppie.com/2016/07/11/programmatic-navigation-view-controllers-in-swift-3-0/")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
    }
    
    
    func  loadMyHeml()
    {
        let localfilePath = Bundle.main.url(forResource: "Introduction", withExtension: "html")
        let myRequest =  URLRequest(url: localfilePath!)
        webView.loadRequest(myRequest)
    }
    
    
    
}
