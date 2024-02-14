//
//  DetailViewController.swift
//  SimpleCancel
//
//  Created by mark on 2022-11-05.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        print("cancel")
//        print(self.presentedViewController!)
        dismiss(animated: true)
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton)
    {
        if (self.presentedViewController != nil)
        {
            print(self.presentedViewController!)
        }
        else
        {
            print("presentedViewController is nil")
        }
//        dismiss(animated: true)
        if (self.navigationController != nil)
        {
            print(self.navigationController!)
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            print("navigation controller is nil")
        }
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
