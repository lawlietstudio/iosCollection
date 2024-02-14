//
//  ItemTableViewController.swift
//  SoloLearnToDoList
//
//  Created by mark on 2022-11-05.
//

import UIKit

class ItemTableViewController: UITableViewController {
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        loadSampleItems()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load saved items
        if let savedItems = loadItems() {
            items += savedItems
        }
    }
    
    func loadSampleItems()
    {
        items += [Item(name:"Item1"), Item(name:"Item2"), Item(name:"Item3")]
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        let item = items[indexPath.row]
        
        cell.nameLabel.text = item.name
        
        // Configure the cell...
        
        return cell
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue)
    {
        let srcViewCon = sender.source as? ViewController
        let item = srcViewCon?.item
        if (srcViewCon != nil && item?.name != "")
        {
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                // Update the existing item
                items[selectedIndexPath.row] = item!
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else
            {
                // Add a new item
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(item!)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            saveItems()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"
        {
            let detailViewCon = segue.destination as! ViewController
            if let selectedCell = sender as? ItemTableViewCell
            {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = items[indexPath.row]
                detailViewCon.item = selectedItem
            }
        }
        else if segue.identifier == "AddItem"
        {
            
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        saveItems()
    }
    //
    //    func saveItems() {
    //       let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
    //       if !isSaved {
    //         print("Failed to save items...")
    //       }
    //    }
    
    func saveItems()
    {
        do
        {
            let isSaved = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: true)
            try isSaved.write(to: Item.ArchiveURL)
        }
        catch
        {
            print("\(error)")
        }
    }
    
    func loadItems() -> [Item]?
    {
        if let data = NSData(contentsOf: Item.ArchiveURL)
        {
            do
            {
                if let loadedItem = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as Data) as? [Item]
                {
                    return loadedItem
                }
            }
            catch
            {
                
            }
        }
        return nil
    }
    
    // Override to support rearranging the table view.
    //    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //
    //    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
