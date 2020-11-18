//
//  TodoListTVC.swift
//  Todoey List
//
//  Created by Bruna Fernanda Drago on 18/11/20.
//

import UIKit

class TodoListTVC: UITableViewController {
    

    
    var itemArray = [Item]()
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Eleven"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem.title = "Dustin"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem.title = "Mike"
        itemArray.append(newItem3)

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary operator (usado para diminuir linhas de código de if statements)=> value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Items
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTxtField) in
            alertTxtField.placeholder = "Create new item"
            textField = alertTxtField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
         
    }
}
