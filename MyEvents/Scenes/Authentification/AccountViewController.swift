//
//  AccountViewController.swift
//  MyEvents
//
//  Created by ouali on 23/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class AccountViewController: UIViewController {

    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let db = Firestore.firestore()

        if let user = Auth.auth().currentUser {
            // user connect
            let docRef = db.collection("users").document(user.uid)
            
           docRef.getDocument { (document, error) in
           if let document = document, document.exists {
                self.firstnameTextField.text = document["firstname"] as? String
                self.lastnameTextField.text = document["lastname"] as? String
                self.emailTextField.text = document["email"] as? String
                self.phoneTextField.text = document["phone"] as? String
               } else {
                   print("Document does not exist")
               }
           }
        } else {
            fatalError(" Erreur : aucun user connect")
        }
    }

    @IBAction func touchSave(_ sender: Any) {
   
                   
        let firstname = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastname = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        // Set the "capital" field of the city 'DC'
        userRef.updateData([
            "email": email,
            "firstname": firstname,
            "lastname": lastname,
            "phone": phone,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }

    }
    
    @IBAction func touchBack(_ sender: Any) {
        let webViewhome = HomeEventsOrgViewController()
        self.view.window?.rootViewController = webViewhome
        self.view.window?.makeKeyAndVisible()   
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }



}
