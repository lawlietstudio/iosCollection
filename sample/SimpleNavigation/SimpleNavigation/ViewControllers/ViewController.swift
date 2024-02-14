//
//  ViewController.swift
//  SimpleNavigation
//
//  Created by mark on 2023-03-05.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func navigateToOtherStoryboardView(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
//        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
//        let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        self.present(vc, animated: true)
    }
    
    @IBAction func performSegueByCode(_ sender: Any)
    {
        performSegue(withIdentifier: "SegueOne", sender: nil)
    }
    
    @IBAction func showXIB(_ sender: Any) {
        
//        let vc = XIBViewController(nibName: "XIBViewController", bundle: nil)
        let vc = XIBViewController()
        // SecondViewController can't be init like this
//        let vc = SecondViewController()
//        let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        self.present(vc, animated: true)
    }
    
    @IBAction func navigateToOtherStoryboard(_ sender: Any)
    {
        let otherStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        // get the initial viewController of the storyboard
        let vc = otherStoryboard.instantiateInitialViewController()!
//        let vc = otherStoryboard.instantiateInitialViewController(withIdentifier: "EmptyViewController") as! EmptyViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func navigateToSwiftUIView(_ sender: Any)
    {
        let swiftUIView = SwiftUIView()
        let vc = UIHostingController(rootView: swiftUIView)
        
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true)
    }
}

