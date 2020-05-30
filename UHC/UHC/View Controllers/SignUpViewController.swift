//
//  SignUpViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 25/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    func setUpUI() {
        
        errorLabel.alpha = 0
        setupTitleLabel()
        setupSignInButton()
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message.
    func validateFields() -> String? {
        // Check that all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
    
    @IBAction func signUpTapped(_ sender: Any) {
    // Validate the fields
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields show error message
            showError(error!)
        } else {
        
            // Create cleaned versions of the data
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                
                //Check for errors
                if err != nil {
                    // there was an error creating the user
                    self.showError("Error creating user")
                } else {
                    //User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["username" : username, "uid": result!.user.uid]) { (error) in
                        
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                }
                
                // Transition to the home screen
                self.transitionToHome()
            }
        }
    }
    
    func showError(_ message:String) {
         errorLabel.text = message
         errorLabel.alpha = 1
     }
         
     func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
         
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
     }
    
    
    

}
