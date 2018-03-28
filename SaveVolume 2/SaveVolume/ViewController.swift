//
//  ViewController.swift
//  SaveVolume
//
//  Created by robin on 2017-11-08.
//  Copyright © 2017 robin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //variables
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        // save the volume to the UserDefaults library
        defaults.set(sender.value, forKey:"volume")
        
        // print the volume to the console and label
        print(sender.value)
        volumeLabel.text = "Volume is set to: \(sender.value)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // get the volume from UserDefaults library
        let v = defaults.float(forKey: "volume")
        slider.value = v
        
        // output the volume to the console and label
        print(v)
        volumeLabel.text = "Volume is set to: \(v)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }

}

