//
//  SecondViewController.swift
//  SimpleNavigation
//
//  Created by mark on 2023-03-05.
//

import UIKit

class SecondViewController: UIViewController {
    var count = 0
    @IBOutlet weak var lblCount: UILabel!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count += 1;
        lblCount.text = "\(count)"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count += 1;
        lblCount.text = "\(count)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
