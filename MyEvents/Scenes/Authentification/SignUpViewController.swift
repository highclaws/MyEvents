//
//  SignUpViewController.swift
//  MyEvents
//
//  Created by ouali on 22/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    //Outlet
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    //Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        ErrorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    // private function
    private func setupButton() {
        SignUpButton.layer.cornerRadius = 20
        LoginButton.layer.cornerRadius = 20
        LoginButton.layer.borderWidth = 3
        LoginButton.layer.borderColor = UIColor.red.cgColor
    }
    private func setupTextFieldManager() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    // Action
    @objc private func hideKeyboard(){
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    func valedateFields() -> String? {
        let username = usernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        // check that all fields are filled in
        if username.trimmingCharacters(in: .whitespacesAndNewlines) == "" && email.trimmingCharacters(in: .whitespacesAndNewlines) == "" && password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Erreur : les champs ne sont pas complets"
        }
        return nil
    }
    
    @IBAction func touchToSignUp(_ sender: Any) {
        
        
        let error = valedateFields()
        
        if error != nil {
            showError(error!)
        } else {
        let username = usernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!

            print("Inscription de \(usernameTextField.text ?? "")")
            Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                
             
                
                    let db = Firestore.firestore()
                
                    var ref: DocumentReference? = nil
                ref = db.collection("users").addDocument(data: [
                    "username": username,
                    "email": email,
                    "password": password
                ]) { (err) in
                    
                    if err != nil {
                        self.showError("error saveing data user")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        // todo
                        //transitionToHomeEvent()
                    }
                }
            }
        }
    }
    
    @IBAction func touchToLogin(_ sender: Any) {
        guard let navigationView = self.navigationController?.view else {
            return
        }
        UIView.transition(with: navigationView, duration: 0.5, options: .transitionFlipFromTop, animations: {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        })
    }
    func showError(_ message:String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    func transitionToHomeEvent() {
        // todo
        print("transit")
        //storyboard?.instantiateViewController(identifier: storyboard.HomeEvents)
    }
    
}
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
