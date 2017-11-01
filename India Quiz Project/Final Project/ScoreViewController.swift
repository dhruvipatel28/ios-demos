//
//  ScoreViewController.swift
//  Final Project
//
//  Created by MacStudent on 2017-10-31.
//  Copyright © 2017 Dhruv Patel. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UITableViewDataSource , UITableViewDelegate
{
   @IBOutlet weak var tbl_score: UITableView!
   override func viewDidLoad()
    {
        super.viewDidLoad()
        tbl_score.dataSource = self
        tbl_score.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print("Total result : " , DeshBoardViewController.allResult.count)
        return DeshBoardViewController.allResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbl_score.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)//"resultCell")
        let score = DeshBoardViewController.allResult[indexPath.row] as [Int]
        cell.textLabel?.text = "Right : \(score[0]) , Wrong : \(score[1]) , Unattempted : \(score[2])"
        
        if(indexPath.row%2 == 0 || indexPath.row == 0)
        {
               cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else
        {
              cell.backgroundColor = #colorLiteral(red: 0.8797677159, green: 0.9745202661, blue: 1, alpha: 1)
        }
        return cell
    }
    
    @IBAction func btn_done(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil )
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}
