//
//  ViewController.swift
//  SimpleNavigation
//
//  Created by mark on 2023-03-05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func click(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//        let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        self.present(vc, animated: true)
    }
    
    @IBAction func showXIB(_ sender: Any) {
//        let vc = XIBViewController(nibName: "XIBViewController", bundle: nil)
        let vc = XIBViewController()
//        let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        self.present(vc, animated: true)
    }
}

