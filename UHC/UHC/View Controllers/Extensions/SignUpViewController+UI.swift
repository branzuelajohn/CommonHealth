//
//  SignUpViewController+UI.swift
//  UHC
//
//  Created by John Branzuela on 29/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit

extension SignUpViewController {
    func setupTitleLabel() {
        let title = "Sign Up"
        let attributedText = NSMutableAttributedString(string: title, attributes:
            [NSAttributedString.Key.font : UIFont.init(name: "Didot", size : 28)!,
             NSAttributedString.Key.foregroundColor : UIColor.white])
        titleTextLabel.attributedText = attributedText
    }
    
    func setupSignInButton() {
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font
            : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(white : 1, alpha : 0.65)])
        let attributedSubText = NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedText.append(attributedSubText)
        signInButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
        
    }
}
