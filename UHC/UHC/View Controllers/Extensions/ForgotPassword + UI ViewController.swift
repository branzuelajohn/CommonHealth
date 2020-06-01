//
//  ForgotPassword + UI ViewController.swift
//  UHC
//
//  Created by John Branzuela on 31/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit

extension ForgotPasswordViewController {
    
    func setupEmailTextField() {
        
        emailTextField.borderStyle = .none
        let placeholderAttr = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red:170/255,green: 170/255, blue:170/255, alpha:1)])
        emailTextField.attributedPlaceholder = placeholderAttr
        emailTextField.textColor = UIColor(red: 99/255, green:99/255, blue:99/255, alpha:1)
    }
    func setupResetButton() {
        resetButton.setTitle("RESET MY PASSWORD", for: UIControl.State.normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        resetButton.backgroundColor = UIColor.black
        resetButton.layer.cornerRadius = 5
        resetButton.clipsToBounds = true
        resetButton.setTitleColor(.white, for: UIControl.State.normal)
        
    }
}
    

  


