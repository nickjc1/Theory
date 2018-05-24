//
//  ViewController.swift
//  Todoey
//
//  Created by CHAO JIANG on 5/23/18.
//  Copyright © 2018 nickjc1. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //Declare veriable here:
    var itemArray : [String] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let todoListArray = defaults.array(forKey: "TodoList") {
            itemArray = todoListArray as! [String]
        }
    }

    //MARK - TableView DataSource Methods:
    
    //Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell;
    }

    //Declare numOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    //MARK - TableView Delegate Method:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - addButton:
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //declare a local variable:
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let addItemAction = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            if textField.text != "" {
                self.itemArray.append(textField.text!)
            } else {
                self.itemArray.append("New Item")
            }
            self.defaults.set(self.itemArray, forKey: "TodoList")
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (action) in
            print("dismiss")
        }
        
        alert.addAction(addItemAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { (alertTextField) in
            print("add TextField into alert")  //test
            
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }

       
        
        
        
        present(alert, animated: true, completion: nil)
        
    }
    

}
