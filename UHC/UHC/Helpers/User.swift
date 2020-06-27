//
//  User.swift
//  UHC
//
//  Created by Liu Xiaowen on 25/6/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
    
class User {
    
    //Properties
    var name: String
    var nric: String
    
    //Initialization
    init? (name:String, nric:String) {
        
        if (name.isEmpty || nric.isEmpty) {
            return nil
        }
        
        self.name = name
        self.nric = nric
    }
}
