//
//  LoginViewController.swift
//  MyEvents
//
//  Created by ouali on 22/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import Foundation


class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var SignUpButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.alpha = 0

        // Do any additional setup after loading the view.
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
                        //self.showError(error! as! String)
                    } else {
                        print(user as Any)
                
                        let webView = HomeEventsViewController()
                        self.view.window?.rootViewController = webView
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
