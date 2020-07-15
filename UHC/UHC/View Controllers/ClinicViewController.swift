//
//  ClinicViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 18/6/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import os.log
import Firebase

class ClinicViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var QButton: UIButton!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var warningLabel: UILabel!
    
    var clinic: Clinic?
    let db = Firestore.firestore()
    var QNumber = 0;
    var inQueue = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let clinic = clinic {
            navigationItem.title = clinic.name
            nameLabel.text = clinic.name
            photoImageView.image = clinic.photo
        }
        Utilities.styleFilledButton(self.QButton)
        update()
    }
    
    // MARK: - Navigation
    func update() {
        
        db.collection("clinics").document(clinic!.name).getDocument{ (document, error) in
            if let document = document, document.exists {
                self.QNumber = document.get("Next Qnumber") as! Int
                let current = document.get("Currently Serving") as! Int
                self.currentLabel.text = "Number of people currently in queue: " + (String)(self.QNumber - current - 1)
                let location = document.get("Location") as! String
                let time = document.get("Operating Hours") as! String
                self.descriptionTextView.text = "Location: \(location) \n\n" + "Operating Hours: \n\((time).replacingOccurrences(of: "\n", with: "\n"))"
            } else {
                print("Document does not exist")
            }
        }
        
        let email = UserDefaults.standard.string(forKey: "useremail")!
        db.collection("users").document(email).getDocument{ (document, error) in
            if let document = document, document.exists {
                self.inQueue = document.get("In Queue") as! Bool
                if (self.inQueue == false) {
                    self.warningLabel.alpha = 0;
                } else {
                    self.warningLabel.alpha = 1;
                    let currClinic = document.get("Clinic") as! String
                    let currNum = document.get("Qnum") as! Int
                    self.db.collection("users").document(email).setData(["LastClinic": currClinic, "LastQNum": currNum], merge: true)
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name = nameLabel.text ?? ""
        let photo = photoImageView.image
        super.prepare(for: segue, sender: sender)
        clinic = Clinic(name: name, photo: photo, description: "")
        guard let ticketDetailViewController = segue.destination as? TicketViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        ticketDetailViewController.clinic = clinic
        ticketDetailViewController.Qnum = self.QNumber
    }
    
    
    @IBAction func QButtonTapped(_ sender: Any) {
        let userEmail = UserDefaults.standard.string(forKey: "useremail")!
        db.collection("users").document(userEmail).getDocument{ (document, error) in
            if let document = document, document.exists {
                if (self.warningLabel.alpha == 1) {
                    let clinic = document.get("LastClinic") as! String
                    let Qnum = document.get("LastQNum") as! Int
                    self.db.collection("clinics").document(clinic).collection("queue").document(String(Qnum)).setData(["Cancelled": true], merge: true)
                }
            } else {
                print("Document does not exist")
            }
        }
        
    }
}
