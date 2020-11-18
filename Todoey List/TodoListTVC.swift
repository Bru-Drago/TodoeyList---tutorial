//
//  TodoListTVC.swift
//  Todoey List
//
//  Created by Bruna Fernanda Drago on 18/11/20.
//

import UIKit

class TodoListTVC: UITableViewController {
    
    let itemArray = ["Eleven","Mike","Dustin","Lucas","Nancy","Steve","Max","Will","Jim Hopper","Joyce Byers","Jonathan","Barbie","Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
}
