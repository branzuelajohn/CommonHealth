//
//  Clinic.swift
//  UHC
//
//  Created by Liu Xiaowen on 18/6/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import Firebase

class Clinic {
    
    //Properties
    var name: String
    var photo: UIImage?
    var description: String?
    
    //Initialization
    init? (name: String, photo: UIImage?, description: String?) {
        
        if (name.isEmpty) {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.description = description
    }
}
