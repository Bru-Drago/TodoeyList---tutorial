//
//  TodoListTVC.swift
//  Todoey List
//
//  Created by Bruna Fernanda Drago on 18/11/20.
//

import UIKit

class TodoListTVC: UITableViewController {
    
    var itemArray = ["Eleven","Mike","Dustin","Lucas","Nancy","Steve","Max","Will","Jim Hopper","Joyce Byers","Jonathan","Barbie","Demogorgon"]
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = userDefaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Items
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //fazer uma verificação para textField vazia
            self.itemArray.append(textField.text!)
            
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
