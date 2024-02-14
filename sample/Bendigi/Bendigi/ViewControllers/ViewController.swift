//
//  ViewController.swift
//  Bendigi
//
//  Created by mark on 2022-11-03.
//

import UIKit

class ViewController: UIViewController {
    var post : Post?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblName.text = post?.name ?? ""
        lblEmail.text = post?.email ?? ""
        lblId.text = String(post!.id)
        lblBody.text = post?.body ?? ""
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

