//
//  FirstViewController.swift
//  notification
//
//  Created by Capgemini-DA164 on 9/6/22.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(facebook(notification:)), name: .facebook, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(twiter(notification:)), name: .twiter, object: nil)
        
    }
    @objc func facebook(notification:Notification) {
        label.text = "Facebook"
    }
    @objc func twiter(notification:Notification) {
        label.text = "Twiter"
    }
    
}
    extension Notification.Name {
        static let facebook = Notification.Name("Facebook")
        static let twiter = Notification.Name("Twiter")
    }


