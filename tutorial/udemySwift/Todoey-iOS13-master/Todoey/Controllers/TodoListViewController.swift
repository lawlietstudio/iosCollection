//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category?
    {
        didSet {
            loadItems()
        }
    }
//    var defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
                
        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destory Demogorgon"
//        itemArray.append(newItem3)
        
        // load from userDefault
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]
//        {
//            itemArray = items
//        }
        
//        searchBar.delegate = self
        
//        loadItems()
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        // update
//        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        // delete
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
//        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark)
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default)
        {
            (action) in
            // what will happen once the user clicks the Add Item button on out UIAlert
//            print(textField.text)
            
//            let newItem = Item()
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        alert.addTextField { alertTextField in
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems()
    {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest())
    {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let searchPredicate = request.predicate
        {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, searchPredicate])
        }
        else
        {
            request.predicate = categoryPredicate
        }
        
//        if let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, request.predicate])
//        {
//            request.predicate = compoundPredicate
//        }
        
        do {
            itemArray =  try context.fetch(request)
        }
        catch
        {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        // [cd] case insensitive
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
        print(searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
