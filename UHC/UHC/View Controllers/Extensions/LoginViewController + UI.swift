//
//  LoginViewController + UI.swift
//  UHC
//
//  Created by John Branzuela on 29/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit

extension LoginViewController {
    func setupTitleLabel() {
        let title = "Sign In"
        let attributedText = NSMutableAttributedString(string: title, attributes:
            [NSAttributedString.Key.font : UIFont.init(name: "Didot", size : 28)!,
             NSAttributedString.Key.foregroundColor : UIColor.white])
        titleTextLabel.attributedText = attributedText
    }
    
    func setupSignUpButton() {
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font
            : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(white : 1, alpha : 0.65)])
        let attributedSubText = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedText.append(attributedSubText)
        signUpButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
        
    }
}
