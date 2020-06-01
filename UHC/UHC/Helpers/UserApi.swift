//
//  UserApi.swift
//  UHC
//
//  Created by John Branzuela on 1/6/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase


class UserApi {
    func signUp(withUsername username: String, email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
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
    }
}
