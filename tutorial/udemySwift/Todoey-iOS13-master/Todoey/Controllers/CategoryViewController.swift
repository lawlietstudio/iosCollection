//
//  CategoryViewController.swift
//  Todoey
//
//  Created by mark on 25/10/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategorys()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            desinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Category", style: .default)
        {
            (action) in
            // what will happen once the user clicks the Add Item button on out UIAlert
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategorys()
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        alert.addTextField { alertTextField in
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategorys()
    {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategorys(with request: NSFetchRequest<Category> = Category.fetchRequest())
    {
        do {
            categoryArray =  try context.fetch(request)
        }
        catch
        {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}
