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
                // create cleaned textfield
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                // connection
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
                    if error != nil {
                        // couldn'it sign in
                        self.showError("Mot de passe incorrect")
                        print(error.debugDescription)
                    } else {
                         // user connect
                         let webViewOrg = HomeEventsOrgViewController()
                         self.view.window?.rootViewController = webViewOrg
                         self.view.window?.makeKeyAndVisible()
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
