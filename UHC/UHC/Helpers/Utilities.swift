//
//  Utilities.swift
//  UHC
//
//  Created by Liu Xiaowen on 26/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield: UITextField) {
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 203/255, green: 67/255, blue: 67/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 25.0
    }
    
    static func styleLabel(_ label:UILabel) {
        label.font = UIFont(name: "Futura-Bold", size: 30)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
           
           let passwordTest = NSPredicate(format:
           "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
           return passwordTest.evaluate(with: password)
       }
    
}
