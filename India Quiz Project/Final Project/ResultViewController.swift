//
//  ViewController.swift
//  Final Project
//
//  Created by MacStudent on 2017-10-17.
//  Copyright © 2017 Dhruv Patel. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController
{
    @IBOutlet weak var lbl_right_answer: UILabel!
    @IBOutlet weak var lbl_wrong_answer: UILabel!
    @IBOutlet weak var lbl_unattended_answer: UILabel!
    
    @IBAction func btn_done(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil )
    }
    
    static var wrong : Int = 0
    static var right : Int = 0
    static var unattended : Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lbl_right_answer.text = lbl_right_answer.text! + String(ResultViewController.right)
        lbl_wrong_answer.text = lbl_wrong_answer.text! + String(ResultViewController.wrong)
        lbl_unattended_answer.text = lbl_unattended_answer.text! + String(ResultViewController.unattended)
        saveMyScore()
    }

    func saveMyScore()
    {
        var result = [ResultViewController.right , ResultViewController.wrong , ResultViewController.unattended]
        DeshBoardViewController.allResult.append(result)
        print(" \n\n\n     result add " , DeshBoardViewController.allResult.description )
        
        LoginViewController.loginUserDefault.set(DeshBoardViewController.allResult, forKey: "AllResult")
        LoginViewController.loginUserDefault.set(ResultViewController.right, forKey: "right")
        LoginViewController.loginUserDefault.set(ResultViewController.wrong, forKey: "wrong")
        LoginViewController.loginUserDefault.set(ResultViewController.unattended, forKey: "unattended")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
