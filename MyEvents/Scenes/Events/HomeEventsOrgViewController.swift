//
//  HomeEventsOrgViewController.swift
//  MyEvents
//
//  Created by ouali on 25/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeEventsOrgViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            // user connect
            nameLabel.text = user.email!
        } else {
            fatalError(" Erreur : aucun user connect")
        }
        // Do any additional setup after loading the view.
    }


    @IBAction func touchSignOut(_ sender: Any) {
        try! Auth.auth().signOut()

        let webView = LoginViewController()
        self.view.window?.rootViewController = webView
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func touchToAccount(_ sender: Any) {
        let webView = AccountViewController()
        self.view.window?.rootViewController = webView
        self.view.window?.makeKeyAndVisible()
    }
}
