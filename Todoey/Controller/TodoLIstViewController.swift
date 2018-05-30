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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
//         print(dataFilePath)
        loadItems()
    }

    //MARK - TableView DataSource Methods:
    
    //Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //ternery operator to rewrite code:
        cell.accessoryType = item.isChecked ? .checkmark : .none
//        if itemArray[indexPath.row].isChecked {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell;
    }

    //Declare numOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    //MARK - TableView Delegate Method:
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
    }
    
    //MARK - addButton:
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //declare a local variable:
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let addItemAction = UIAlertAction(title: "Add Item", style: .default) {(action) in
            
            let item = Item()
            item.title = textField.text!
            self.itemArray.append(item)
            
            self.saveItems()
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
    
    //save items method:
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("error decoding item array \(error)")
            }
        }
    }
    

}
