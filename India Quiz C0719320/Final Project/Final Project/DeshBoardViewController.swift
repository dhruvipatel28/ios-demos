//
//  DeshBoardViewController.swift
//  Final Project
//
//  Created by MacStudent on 2017-10-23.
//  Copyright © 2017 Dhruv Patel. All rights reserved.
// #00897B , #B2DFDB ,,#E0F2F1
// https://material.io/guidelines/style/color.html?gclid=EAIaIQobChMI8YiAzIeI1wIVlFuGCh2fbwGAEAAYASAAEgLWs_D_BwE#color-color-palette


/*

 It is the second most populous country in the entire world and one of the biggest on the globe. With some of the oldest civilizations in the world, some of the most diverse cultures and wildlife in the world, India is a place that you could spend an entire life exploring and you would still have one third of it to see.
 
 So why not take a minute and try out this quiz that we have prepared for you on one of the greatest nations? What is the approximate population of India? India was part of what country’s great empire until the 20th century? In how many wars with its neighbor, Pakistan, has India been involved? Indian food will also be among the topics - so try it out!
 
 */


import UIKit

class DeshBoardViewController: UIViewController
{
    @IBOutlet var bg_view: UIView!
    @IBOutlet weak var lbl_quizinfo: UILabel!
    @IBOutlet weak var btn_start: UIButton!
    @IBOutlet weak var btn_introduction: UIButton!
    @IBOutlet weak var btn_score: UIButton!
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //apper
    static var QuizDidApper : Bool = false
    static var allResult =  [[Int]]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Dash Board"
        DeshBoardViewController.QuizDidApper  = false
     }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
     }
    
    //btn click events
    
    @IBAction func btn_logout(_ sender: UIBarButtonItem)
    {
        LoginViewController.loginUserDefault.removeObject(forKey: "userName")
        LoginViewController.loginUserDefault.removeObject(forKey: "password")
        LoginViewController.loginUserDefault.removeObject(forKey: "AllResult")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_score(_ sender: UIButton)
    {
        if((LoginViewController.loginUserDefault.value(forKey: "AllResult") ) != nil)
        {
            DeshBoardViewController.allResult = LoginViewController.loginUserDefault.value(forKey: "AllResult") as! [[Int]]
            let ScoreViewController = storyBoard.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            self.present(ScoreViewController, animated: true, completion: nil)
        }
        else
        {
            //"Do not have any result new user"
            DeshBoardViewController.allResult = [[Int]]()
            LoginViewController.loginUserDefault.set(DeshBoardViewController.allResult, forKey: "AllResult")
        }
     }
    
    
    @IBAction func btn_introduction_click(_ sender: UIButton)
    {
        let nextScreen = storyBoard.instantiateViewController(withIdentifier: "information_viewControllerViewController") as! information_viewControllerViewController
        self.present(nextScreen, animated: true, completion: nil)
    }
    
    
    @IBAction func btn_start_click(_ sender: UIButton)
    {
        let StartQuiz = storyBoard.instantiateViewController(withIdentifier: "quizViewController") as! quizViewController
        self.present(StartQuiz, animated: true, completion: nil)
    }
    
       
    
    // bg image functions
    func getUIColorFromRGBString(value: String) -> UIColor
    {
        let str = value.lowercased().replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "0x", with: "");
        return getUIColorFromRGBHexValue(value: Int(str, radix: 16)!);
    }

    func getUIColorFromRGBHexValue(value: Int) -> UIColor
    {
        return getUIColorFromRGBThreeIntegers(red: (value & 0xFF0000) >> 16,
                                              green: (value & 0x00FF00) >> 8,
                                              blue: value & 0x0000FF)
    }
    
    func getUIColorFromRGBThreeIntegers(red: Int, green: Int, blue: Int) -> UIColor
    {
        return UIColor(red: CGFloat(Float(red) / 255.0),
                       green: CGFloat(Float(green) / 255.0),
                       blue: CGFloat(Float(blue) / 255.0),
                       alpha: CGFloat(1.0))
    }
    
}


//https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
//
