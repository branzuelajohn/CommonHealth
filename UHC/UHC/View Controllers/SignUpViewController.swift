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
import ProgressHUD


class SignUpViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var NRICTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        datePickerStyler()
    }
    
    func setUpUI() {
        
        errorLabel.alpha = 0
        Utilities.styleLabel(titleTextLabel)
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleTextField(confirmEmailTextField)
        Utilities.styleTextField(NRICTextField)
        Utilities.styleTextField(mobileNumberTextField)
        Utilities.styleTextField(confirmPasswordTextField)
        Utilities.styleTextField(dobTextField)
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message.
    func validateFields() -> String? {
        // Check that all fields are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            NRICTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            mobileNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        // Check whether mobile number is valid (has 8 numbers)
        let mobileNum = mobileNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if mobileNum.count != 8 {
            return "Invalid mobile number"
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmedpw = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        if confirmedpw != cleanedPassword {
            // Passwords are not the same
            return "Please make sure your passwords are the same."
        }
        
        // Check whether emails are the same
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmEmail = confirmEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if email != confirmEmail {
            return "Emails are not the same"
        }
        
        // Check whether NRIC is valid (TO DO!!!)
        
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    // Validate the fields
        self.view.endEditing(true)
        let error = validateFields()
        ProgressHUD.show()
        
        if error != nil {
            // There's something wrong with the fields show error message
            ProgressHUD.showError(error!)
            showError(error!)
        } else {
        
            // Create cleaned versions of the data
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let NRIC = NRICTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobileNum = mobileNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dob = dobTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                
                //Check for errors
                if err != nil {
                    // there was an error creating the user
                    ProgressHUD.showError("Error creating user")
                    self.showError("Error creating user")
                } else {
                    //User was created successfully, now store the first name and last name
                    ProgressHUD.dismiss()
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["username" : name, "NRIC" : NRIC, "Mobile Number" : mobileNum, "Date Of Birth" : dob , "uid" : result!.user.uid]) { (error) in
                        
                        
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
    
    
    func datePickerStyler() {
        // Create a tool bar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Make the bar "Done" button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        // Assign the Toolbar
        dobTextField.inputAccessoryView = toolbar
        
        // Assign the datePicker to text field
        dobTextField.inputView = datePicker
        
        // Datepicker mode
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dobTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    

}
