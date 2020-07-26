//
//  ProfilePageViewController.swift
//  UHC
//
//  Created by John Branzuela on 26/7/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfilePageViewController: UIViewController {

    
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var NRICTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var gender : Bool!
    let datePicker = UIDatePicker()
    let db = Firestore.firestore()
    let email = UserDefaults.standard.string(forKey: "useremail")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerStyler()
        preparePlaceHolders()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
    
    func preparePlaceHolders() {
        
        // Email PlaceHolder
        emailTextField.placeholder = email
        db.collection("users").document(email).getDocument{ (document, error) in
        if let document = document, document.exists {
            let dateOfBirth = document.get("Date Of Birth") as! String
            let mobNum = document.get("Mobile Number") as! String
            let NRIC = document.get("NRIC") as! String
            let name = document.get("Name") as! String
            // Date Of Birth PlaceHolder
            self.dobTextField.placeholder = dateOfBirth
            // Mobile Number PlaceHolder
            self.mobileNumberTextField.placeholder = mobNum
            // NRIC PlaceHolder
            self.NRICTextField.placeholder = NRIC
            // Name PlaceHolder
            self.nameTextField.placeholder = name
        
                }
            }
    }
    
    @IBAction func maleButtonPressed(_ sender: Any) {
        gender = true
               maleButton.backgroundColor = .lightGray
               femaleButton.backgroundColor = .white
    }
    
    @IBAction func femaleButtonPressed(_ sender: Any) {
        gender = false
               maleButton.backgroundColor = .white
               femaleButton.backgroundColor = .lightGray
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if gender == true {
            db.collection("users").document(email).setData(["Gender" : "Male"], merge: true)
            
        } else if gender == false {
            db.collection("users").document(email).setData(["Gender" : "Female"], merge: true)
            
            
        } else {
            print("Gender not selected")
        }
        
    }
    
}
