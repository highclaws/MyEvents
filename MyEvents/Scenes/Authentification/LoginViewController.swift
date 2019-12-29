//
//  LoginViewController.swift
//  MyEvents
//
//  Created by ouali on 22/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase


class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var SignUpButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    var db = Firestore.firestore()
    weak var customView : UIView!


     @objc func btnButtonClicked(_ gesture : UITapGestureRecognizer) {
       self.navigationController?.popViewController(animated: true)
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        checkConnect()

        ErrorLabel.alpha = 0
        /* back not work
        let newBackButton = UIBarButtonItem(title: "< back", style: .plain, target: nil, action: nil)
        
        self.navigationItem.leftBarButtonItem = newBackButton
         
        self.navigationController?.navigationItem.backBarButtonItem =
        UIBarButtonItem(title:"Title", style:.plain, target:nil, action:nil)
         */
    }
    private func setupButton() {
        SignUpButton.layer.cornerRadius = 20
        LoginButton.layer.cornerRadius = 20
        LoginButton.layer.borderWidth = 3
        LoginButton.layer.borderColor = UIColor.red.cgColor
    }

    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
    }
    
    func valedateFields() -> String? {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // check that all fields are filled in
        if email == "" && password == "" {
                return "Erreur : les champs ne sont pas complets"
        }
        return nil
    }

    @IBAction func touchLogin(_ sender: Any) {
        let error = valedateFields()
           
           if error != nil {
               showError(error!)
           } else {
                // create cleaned
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                // connection
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
                    if error != nil {
                        // couldn'it sign in
                        self.showError("Mot de passe incorrect")
                        print(error.debugDescription)
                    } else {
                        //print(user as Any)
                        self.checkConnect()
                    }
                })
        }
    }
    @IBAction func touchSignUp(_ sender: Any) {
        guard let navigationView = self.navigationController?.view else {
            return
        }
        UIView.transition(with: navigationView, duration: 0.5, options: .transitionFlipFromTop, animations: {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
        })
    }
    
    func checkConnect() {
        
        if let user = Auth.auth().currentUser {
           // user connect
           let docRef = self.db.collection("users").document(user.uid)
                  
                 docRef.getDocument { (document, error) in
                 if let document = document, document.exists {
                  
                   if document["role"] as? String == "Utilisateur" {
                           let webViewhome = HomeEventsViewController()
                           self.view.window?.rootViewController = webViewhome
                           self.view.window?.makeKeyAndVisible()
                      } else if document["role"] as? String == "Organisateur" {
                           let webViewOrg = HomeEventsOrgViewController()
                           self.view.window?.rootViewController = webViewOrg
                           self.view.window?.makeKeyAndVisible()
                   }
                 } else {
                         print("Document does not exist")
                     }
                 }
           }
    }
    func showError(_ message:String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
}
extension String {
     func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
}
