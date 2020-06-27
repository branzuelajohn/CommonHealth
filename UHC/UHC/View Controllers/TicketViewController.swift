//
//  TicketViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 24/6/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import Firebase

class TicketViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var NRICLabel: UILabel!
    @IBOutlet weak var clinicLabel: UILabel!
    @IBOutlet weak var QLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    var clinic: Clinic?
    var Qnum: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let clinic = clinic {
            navigationItem.title = clinic.name
            clinicLabel.text = clinic.name
        }
        
        if let Qnum = Qnum {
            navigationItem.title = String(Qnum)
            QLabel.text = String(Qnum)
        }
        
        nameLabel.text = UserDefaults.standard.string(forKey: "username")
        NRICLabel.text = UserDefaults.standard.string(forKey: "usernric")
        
        let db = Firestore.firestore()
         db.collection("clinics").document(clinic!.name).getDocument{ (document, error) in
            if let document = document, document.exists {
                let current = document.get("Currently Serving") as! Int
                self.currentLabel.text = "Currently Serving: " + String(current)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
