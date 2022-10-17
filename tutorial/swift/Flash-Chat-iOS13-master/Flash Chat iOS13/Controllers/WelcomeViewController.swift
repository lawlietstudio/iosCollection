//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName

        // for loop test
//        let fruitBasket = ["Apple", "Pear", "Orange"]
//        for fruit in fruitBasket {
//            print(fruit)
//        }
        
        //
//        titleLabel.text = ""
//        let titleText = "⚡️FlashChat"
//        var charIndex = 0.0
//        for letter in titleText
//        {
//            Timer.scheduledTimer(withTimeInterval: charIndex * 0.1, repeats: false, block: {
//                (timer) in
//                self.titleLabel.text?.append(letter)
//            })
//            charIndex += 1
//        }
    }
    

}
