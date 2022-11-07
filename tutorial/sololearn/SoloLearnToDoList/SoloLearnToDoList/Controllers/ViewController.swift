//
//  ViewController.swift
//  SoloLearnToDoList
//
//  Created by mark on 2022-11-05.
//

import UIKit

class ViewController: UIViewController {
    var item: Item?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let item = item
        {
            nameTextField.text = item.name
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // not working from sololearn since swift 3
//        self.dismiss(animated: true, completion: nil)
        
        // the working code
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if sender as AnyObject? === saveButton
        {
            let name = nameTextField.text ?? ""
            item = Item(name: name)
        }
    }
}

