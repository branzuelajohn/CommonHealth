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
    
    var clinic: Clinic?
    var QNumber = 0
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let clinic = clinic {
            navigationItem.title = clinic.name
            nameLabel.text = clinic.name
            photoImageView.image = clinic.photo
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name = nameLabel.text ?? ""
        let photo = photoImageView.image
        super.prepare(for: segue, sender: sender)
        clinic = Clinic(name: name, photo: photo, description: "")
    }
    
    
    @IBAction func QButtonTapped(_ sender: Any) {
        let clinicName = clinic!.name
        QNumber = (QNumber+1)%1000
        db.collection("clinics").document(clinicName).collection("queue").addDocument(data: ["user": "Test", "Qnumber": QNumber])
    }
}
