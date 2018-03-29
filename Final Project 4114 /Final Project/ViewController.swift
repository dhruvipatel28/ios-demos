//
//  ViewController.swift
//  Final Project
//
//  Created by MacStudent on 2018-03-29.
//  Copyright © 2018 Dhruvi Patel. All rights reserved.
//
/*
 
 Lowest price for bitcoin in past 4 years
 
 https://api.coindesk.com/v1/bpi/historical/close.json&currency=%22MYR%22?start=2013-09-01&end=2013-09-05
 
 https://api.coindesk.com/v1/bpi/historical/close.json?start=2013-09-01&end=2013-09-05
 
 
 
 
 
 */



import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var txtStart: UITextField!
    
    @IBOutlet weak var txtEnd: UITextField!
   let session : URLSession = .shared
    
    @IBOutlet weak var lblAnswer: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnGetAvg(_ sender: Any)
    {
        
        let url = URL(string: "https://api.coindesk.com/v1/bpi/historical/close.json?start=\(txtStart.text!)&end=\(txtEnd.text!)")
        
        
        let task = session.dataTask(with:url!)
        { (data, response, error) in
            
            var i = 0.0;
            var total = 0.0;
            var avg = 0.0;
            
            let json = try? JSONSerialization.jsonObject(with:data!, options : [])
            //print("---------- i ")
            print(json)
            if let x = json as? [String:Any]
            {
                // get the "open" dictionary (don't forget to cast it to [String:Any])
                
                
                
                let bpi = x["bpi"] as? [String:Double]
                for val:Double in bpi!.values
                {
                    i = i + 1.0
                    total = total + val
                   
                    //print(i)
                   // print(val)
                    //print(avg)
                }
                 avg = total/i
                print(avg)
                
            }
            var str : String = String(avg)
            self.lblAnswer.text! = String(str)
            
        }
        task.resume()
        
        
    }
    
    @IBAction func btnLoad(_ sender: Any)
    {
        print(txtStart.text!)
        print(txtEnd.text!)
        
        let url = URL(string: "https://api.coindesk.com/v1/bpi/historical/close.json?start=\(txtStart.text!)&end=\(txtEnd.text!)")
        
        
        let task = session.dataTask(with:url!)
        { (data, response, error) in
            
            
            let json = try? JSONSerialization.jsonObject(with:data!, options : [])
            print("---------- i ")
            print(json)
            if let x = json as? [String:Any]
            {
                // get the "open" dictionary (don't forget to cast it to [String:Any])
                
                var i = 0.0;
                var total = 0.0;
                var avg = 0.0;
                
                let bpi = x["bpi"] as? [String:Double]
                for val:Double in bpi!.values
                {
                    i = i + 1.0
                    total = total + val
                    avg = total/i
                    print(i)
                    print(val)
                    print(avg)
                }
                self.lblAnswer.text! = String(avg)
            }
            
            
        }
         task.resume()
    }
    
    @IBAction func btnGetLow(_ sender: Any)
    {
    }
    
    @IBAction func btnGetMal(_ sender: Any)
    {
        
        let url = URL(string: "https://api.coindesk.com/v1/bpi/historical/close.json&currency=%22MYR%22")
        
        
        let task = session.dataTask(with:url!)
        { (data, response, error) in
            
            
            let json = try? JSONSerialization.jsonObject(with:data!, options : [])
            print("---------- in  MYR ")
            print(json)
            
            
        }
        task.resume()
    }
    
    
    
    
}

