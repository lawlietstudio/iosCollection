//
//  TableViewController.swift
//  Bendigi
//
//  Created by mark on 2022-11-03.
//

import UIKit

class TableViewController: UITableViewController {
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl!) // not required when using UITableViewController
        
        performApiCall()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        performApiCall()
    }
    
    func performApiCall()
    {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")

        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
          // your code here
            if error == nil {
                let decoder = JSONDecoder()
                if let safeDate = data {
                    do {
                        let results = try decoder.decode([Post].self, from: safeDate)
                        DispatchQueue.main.async {
                            self.posts = results
                            self.tableView.reloadData()
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
        })
        
        task.resume()
        
        refreshControl!.endRefreshing()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        as! TableViewCell
        
        let item = posts[indexPath.row]
        
//        cell.textLabel?.text = item.name
        cell.lblName.text = item.name
        cell.lblBody.text = item.body
        // Configure the cell...

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewController = DetailViewController()
//        viewController.post = posts[indexPath.row]
//        self.navigationController?.pushViewController(viewController, animated: true)
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desinationVC = segue.destination as! ViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            desinationVC.post = posts[indexPath.row]
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
