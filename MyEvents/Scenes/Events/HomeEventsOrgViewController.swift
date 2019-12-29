//
//  HomeEventsOrgViewController.swift
//  MyEvents
//
//  Created by ouali on 25/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeEventsOrgViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()

        if let user = Auth.auth().currentUser {
            // user connect
            let docRef = db.collection("users").document(user.uid)
            
           docRef.getDocument { (document, error) in
           if let document = document, document.exists {
               //print(document.data()!)
                self.nameLabel.text = document["username"] as? String
               } else {
                   print("Document does not exist")
               }
           }
        } else {
            fatalError(" Erreur : aucun user connect")
        }
    }
    @objc func touchSearchButton() {
        let mapViewController = SearchViewController()
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    @objc func touchAddButton() {
        let createViewController = EventsCreateViewController()
        self.present(createViewController, animated: true)
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
