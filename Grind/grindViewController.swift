//
//  ViewController.swift
//  Grind
//
//  Created by Daniel Florencio on 12/23/18.
//  Copyright © 2018 Enrique Florencio. All rights reserved.
//

import UIKit

class grindViewController: UITableViewController {

    var itemArray = ["Feed the dog", "Clean the house", "Water plants"]
    
    //Set up the UserDefaults method
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //optional chaining, if the defaults array exists, then set the itemArray equal to items
        //items is just a variable to see if the default array exists
        if let items = defaults.array(forKey: "grindListArray") as? [String] {
            itemArray = items
        }
    }
    
    //Define how many rows you're going to use
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //Create three unique cells for each string in the itemArray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeResuableCell dequeues a cell (Table Views automatically use the queue data structure)
        //So grab cells from the tableView by using its identifier "grindItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "grindItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        print(cell)
        return cell
    }
    
    //Print the row or item that was tapped on
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
                
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //Better UX
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Add new items in the todo list
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //This is the string that the user enters
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Add the new string into the array
            self.itemArray.append(textField.text!)
            
            //Set up the defaults to save the user data
            self.defaults.set(self.itemArray, forKey: "grindListArray")
            
            //Reload the tableview data so that a new cell is allocated for the incoming string
            self.tableView.reloadData()
        }
        
        //Create the textfield for the user to insert the item into
        alert.addTextField { (alertTextField) in
            //"Create new item" is what will be displayed in grey
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //Add the action to our alert
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   
}

