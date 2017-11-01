//
//  quizViewController.swift
//  Final Project
//
//  Created by MacStudent on 2017-10-24.
//  Copyright © 2017 Dhruv Patel. All rights reserved.
// https://www.proprofs.com/quiz-school/topic/india
//1360u0k46vP0dVC1EIj7urobPnc

import UIKit
import GameplayKit

class quizViewController: UIViewController
{
    @IBOutlet weak var btn_option1: UIButton!
    @IBOutlet weak var btn_option2: UIButton!
    @IBOutlet weak var btn_option3: UIButton!
    @IBOutlet weak var btn_option4: UIButton!
    
    @IBOutlet weak var lbl_timer_counter: UILabel!
    @IBOutlet weak var lbl_sec: UILabel!
    @IBOutlet weak var lbl_question: UILabel!
    @IBOutlet weak var lbl_answer1: UILabel!
    @IBOutlet weak var lbl_answer2: UILabel!
    @IBOutlet weak var lbl_answer3: UILabel!
    @IBOutlet weak var lbl_answer4: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var counter_limit = 10
    var selected : String!
    var objectArray : [UIButton]!
    
    //question
    var questionOrder = [String]()
    var answerIndex : String!
    
    var questionNumber : Int = 0
    
    //timer
    var counter : Int = 0
    var timer = Timer()

    // plist var
    var questions : [String:Array<String>] = [:]
    
    //result
    var riteAnswers : Int = 0
    var wrongAnswers : Int = 0
    var notAttempted : Int = 0
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lbl_timer_counter.text = String(counter)
        readPropertyList()
        objectArray = [btn_option1, btn_option2, btn_option3, btn_option4]
        counter = counter_limit
        progressBar.setProgress(Float(counter)/10, animated: true)
        progressBar.tintColor = UIColor.black
        start_timer()
        setNewQustion()
    }
  
    func readPropertyList()
    {
        suffleQuestionLIst() // suffle Question list
        var format = PropertyListSerialization.PropertyListFormat(rawValue: 0)
        var plistData:[String:AnyObject] = [:]  //our data
        let plistPath:String? = Bundle.main.path(forResource: "Questions", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        
        do
        {
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &format!) as! [String : AnyObject]
            questions  = plistData["Data"] as! [String:Array<String>]
        }
        catch
        {
            print("Error reading plist: \(error), format: \(String(describing: format))")
        }
    }
    
    
    func resetAll()
    {
        btn_option1.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option2.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option3.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option4.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
       
        counter = counter_limit
        lbl_sec.textColor = UIColor.black
        lbl_timer_counter.textColor = UIColor.black
        progressBar.tintColor = UIColor.black
        answerIndex = nil
        selected = nil
        
        lbl_timer_counter.text = String(counter)
        lbl_question.text = " "
        lbl_answer1.text = " "
        lbl_answer2.text = " "
        lbl_answer3.text = " "
        lbl_answer4.text = " "
        
        questionNumber += 1
        if(questionNumber >= questionOrder.count)
        {
            ResultViewController.right = Int(riteAnswers)
            ResultViewController.wrong = Int(wrongAnswers)
            ResultViewController.unattended = Int(notAttempted)
            showResult()
         }
        else
        {
            setNewQustion()
            start_timer()
        }
     }
    
    func showResult()
    {
        DeshBoardViewController.QuizDidApper  = true
        self.timer.invalidate()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultViewController = storyBoard.instantiateViewController(
            withIdentifier: "ResultViewController") as! ResultViewController
        self.present(resultViewController, animated: true, completion: nil)
    }
    
    @IBAction func btn_option1_click(_ sender:UIButton)
    {
        selected = sender.restorationIdentifier
        btn_option1.setBackgroundImage(UIImage(named: "selected.png") , for: UIControlState.normal)
        btn_option2.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option3.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option4.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        
    }
    
    @IBAction func btn_option2_click(_ sender:UIButton)
    {
        selected = sender.restorationIdentifier
        btn_option2.setBackgroundImage(UIImage(named: "selected.png") , for: UIControlState.normal)
        btn_option1.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option3.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option4.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        
    }
    
    @IBAction func btn_option3_click(_ sender: UIButton)
    {
        selected = sender.restorationIdentifier
        btn_option3.setBackgroundImage(UIImage(named: "selected.png") , for: UIControlState.normal)
        btn_option2.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option1.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option4.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
    }
    
    @IBAction func btn_option4_click(_ sender: UIButton)
    {
        selected = sender.restorationIdentifier
        btn_option4.setBackgroundImage(UIImage(named: "selected.png") , for: UIControlState.normal)
        btn_option2.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option3.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
        btn_option1.setBackgroundImage(UIImage(named: "unselected.png") , for: UIControlState.normal)
    }
    
    func setNewQustion()
    {
        var answer : [String] = questions[questionOrder[questionNumber]]!
        lbl_question.text = answer[0]
        lbl_answer1.text = answer[1]
        lbl_answer2.text = answer[2]
        lbl_answer3.text = answer[3]
        lbl_answer4.text = answer[4]
        answerIndex =  answer[5]
    }
    
    
    @IBAction func btn_click_next(_ sender: Any)
    {
        if (selected != nil)
        {
            if(selected != answerIndex)
            {
                for buttonObject in objectArray
                {
                    if(buttonObject.restorationIdentifier == selected)
                    {
                        buttonObject.setBackgroundImage(UIImage(named: "red")
                            , for: UIControlState.normal)
                        self.wrongAnswers += 1
                        self.timer.invalidate()
                        let _ = Timer.scheduledTimer(withTimeInterval: 0.40, repeats: false)
                        { (timer) in self.resetAll() }
                    }
                }
            }
            else
            {
                riteAnswers += 1
                resetAll()
            }
           
        } // answer selected
        else
        {
            notAttempted += 1
            resetAll()
        } // not selected the answer
    }
    
    func suffleQuestionLIst()
    {
        while questionOrder.count != 10
        {
            let randomQuesIndex = (arc4random_uniform(10) );
            if(!questionOrder.contains("Q"+String(randomQuesIndex)) )
            {
                questionOrder.append("Q"+String(randomQuesIndex))
            }
        }
        if(questionOrder.contains("Q0"))
        {
            let index = questionOrder.index(of: "Q0")!
            questionOrder.remove(at:index )
            questionOrder.insert("Q10", at: index )
        }
    }
    
    
    @objc func timerAction()
    {
        counter -= 1
        if counter == 0
        {
            counter = counter_limit
            lbl_sec.textColor = UIColor.black
            lbl_timer_counter.textColor = UIColor.black
            progressBar.tintColor = UIColor.black
            
            if (selected == nil)
            {
                //print("Not selected")
                notAttempted += 1
            }
            resetAll()
        }
        if counter == 5
        {
            lbl_sec.textColor = UIColor.red
            lbl_timer_counter.textColor = UIColor.red
            progressBar.tintColor = UIColor.red
        }
        lbl_timer_counter.text = "\(counter)"
        progressBar.setProgress( Float(counter)/10 , animated: true)
    }
    
    func start_timer()
    {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
         selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if DeshBoardViewController.QuizDidApper
        {
            DeshBoardViewController.QuizDidApper  = false
            self.dismiss(animated:  false, completion: nil)
        }
    }
    
} // class
