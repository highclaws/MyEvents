//
//  HomeViewController.swift
//  MyEvents
//
//  Created by ouali on 22/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase


class HomeViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var connectButton: UIButton!
    var db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Høme"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.titleLabel.alpha = 0
    }
   
    @IBAction func touchConnect(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is signed in
                self.checkIfUserIsSignedIn()

                print("ok")
                // go to feature controller
            } else {
                // go to login
                 guard let navigationView = self.navigationController?.view else {
                     return
                 }
                 UIView.transition(with: navigationView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                         self.navigationController?.pushViewController(LoginViewController(), animated: true)
                 })
            }
        }

        
    }
    private func checkIfUserIsSignedIn() {
        
        if let user = Auth.auth().currentUser {
           // user connect
           let docRef = self.db.collection("users").document(user.uid)
                  
                 docRef.getDocument { (document, error) in
                 if let document = document, document.exists {
                           let webViewOrg = HomeEventsOrgViewController()
                           self.view.window?.rootViewController = webViewOrg
                           self.view.window?.makeKeyAndVisible()
                   
                 } else {
                         print("Document does not exist")
                     }
                 }
           }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


