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
import SVProgressHUD

class ForgotPasswordViewController: UIViewController {
   
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        setupResetButton()
        setupEmailTextField()
    }
    
    func showError(_ message:String) {
           errorLabel.text = message
           errorLabel.alpha = 1
    }
   
    @IBAction func ResetButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, email != "" else {
            SVProgressHUD.showError(withStatus: "Please enter an email address")
            SVProgressHUD.setContainerView(self.view)
            SVProgressHUD.dismiss(withDelay: 4.0)
                return
            }
            
            resetPassword(email: email, onSuccess: {
                self.view.endEditing(true)
                SVProgressHUD.showInfo(withStatus: "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password")
                SVProgressHUD.setContainerView(self.view)
                SVProgressHUD.dismiss(withDelay: 4.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                   self.navigationController?.popViewController(animated: true)
                }
            }) { (errorMessage) in
                SVProgressHUD.showError(withStatus: errorMessage)
                SVProgressHUD.setContainerView(self.view)
                SVProgressHUD.dismiss(withDelay: 4.0)
            }
    }
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
                
            } else {
                onError(error!.localizedDescription)
            }
        }
        
    }
}
