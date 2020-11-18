//
//  TodoListTVC.swift
//  Todoey List
//
//  Created by Bruna Fernanda Drago on 18/11/20.
//

import UIKit

class TodoListTVC: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
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
        
        saveItems()
        
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
            
            self.saveItems()
            
            
        }
        alert.addTextField { (alertTxtField) in
            alertTxtField.placeholder = "Create new item"
            textField = alertTxtField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Model Manipulation Methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        } catch {
            print("erro no encoding item array \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            } catch{
                print("erro no decode \(error)")
            }
           
        }
    }
}
