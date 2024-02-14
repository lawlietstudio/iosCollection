//
//  ViewController.swift
//  SimpleCancel
//
//  Created by mark on 2022-11-05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToDetail(_ sender:Any)
    {
        performSegue(withIdentifier: "goToDetail", sender: sender)
    }
}

