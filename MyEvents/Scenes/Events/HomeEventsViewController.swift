//
//  HomeEventsViewController.swift
//  MyEvents
//
//  Created by ouali on 23/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeEventsViewController: UIViewController {

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
            self.navigationController?.pushViewController(webView, animated: true)

             //let homeEventsViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeEventsViewController) as! UIViewController
             self.view.window?.rootViewController = webView
             self.view.window?.makeKeyAndVisible()
    }
    

}
