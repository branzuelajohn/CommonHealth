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
    
    var clinic: Clinic?
    let db = Firestore.firestore()
    var QNumber = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let clinic = clinic {
            navigationItem.title = clinic.name
            nameLabel.text = clinic.name
            photoImageView.image = clinic.photo
        }
        
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
        Utilities.styleFilledButton(self.QButton)
    }
    
    // MARK: - Navigation
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
        let clinicName = clinic!.name
        let userName = UserDefaults.standard.string(forKey: "username")
        let userNRIC = UserDefaults.standard.string(forKey: "usernric")
        print(QNumber)
        db.collection("clinics").document(clinicName).collection("queue").addDocument(data: ["Name": userName!,"NRIC": userNRIC!, "Qnumber": QNumber])
        db.collection("clinics").document(clinicName).setData(["Next Qnumber": QNumber+1], merge: true)
    }
}
