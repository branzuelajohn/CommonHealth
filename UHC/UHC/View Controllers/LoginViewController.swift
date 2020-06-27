//
//  LoginViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 25/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var user = User(name: "default", nric: "default")
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        errorLabel.alpha = 0
        Utilities.styleLabel(titleTextLabel)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message.
    func validateFields() -> String? {
        // Check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               return "Please fill in all fields"
        }
           
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        return nil
    }
  
    @IBAction func loginTapped(_ sender: Any) {
        
        // Validate Text Fields
        //let error = validateFields()
            
        //Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
            if error != nil {
                // Could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                self.transitionToHome()
            }
            self.db.collection("users").document(email).getDocument{ (document, error) in
                if let document = document, document.exists {
                    let username = document.get("Name") as! String
                    let usernric = document.get("NRIC") as! String
                    UserDefaults.standard.set(username, forKey: "username")
                    UserDefaults.standard.set(usernric, forKey: "usernric")
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
}
