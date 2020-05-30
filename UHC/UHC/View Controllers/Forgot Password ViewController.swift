//
//  Forgot Password ViewController.swift
//  UHC
//
//  Created by John Branzuela on 28/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Forgot_Password_ViewController: UIViewController {
    @IBOutlet var resetButton: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
    }
    
   /* @IBAction func resetPasswordDidTapped(_ sender: Any) {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let error = "Please enter an email address for password reset"
            showError(error)
        } else {
            
            
        }
        
    }*/
    
    func showError(_ message:String) {
           errorLabel.text = message
           errorLabel.alpha = 1
    }
    // CODE NOT DONE YET!!!!!!!!!!
    func resetPasword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
   
}
