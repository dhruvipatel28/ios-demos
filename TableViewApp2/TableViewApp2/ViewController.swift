//
//  ViewController.swift
//  TableViewApp2
//
//  Created by MacStudent on 2018-03-14.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // create a data source
    var movies = ["Black Panther", "Avengers: Infinity War", "Shape of the Water", "Padmaavat", "Thugs of Hindostan", "Baaghi 2"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // TableView related functions

    
    
    // tell ios how many rows you want in your table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // tell ios what each cell looks like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dont' forget to change "myCell" to whatever you called it in the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // put some text in each row
        cell.textLabel?.text = movies[indexPath.row]
        
        return cell
    }
    
    // what should happen when you click on stuff
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // show the row number
        print(indexPath.row)
        
        // show what's actually in the row
        print(movies[indexPath.row])
    }
    
    // delete a row of the table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print("going to delete!")
            
            // LOGIC: delete it from the array
            movies.remove(at: indexPath.row)
            
            // UI: delete it from the tableView
            tableView.deleteRows(at: [indexPath], with: .automatic)
        
        }
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

