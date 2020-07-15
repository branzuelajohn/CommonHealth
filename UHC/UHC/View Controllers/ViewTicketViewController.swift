//
//  ViewTicketViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 15/7/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import Firebase

class ViewTicketViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nricLabel: UILabel!
    @IBOutlet weak var clinicLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var csLabel: UILabel!
    @IBOutlet weak var ewtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = UserDefaults.standard.string(forKey: "username")!
        nricLabel.text = UserDefaults.standard.string(forKey: "usernric")!
        let db = Firestore.firestore()
        let userEmail = UserDefaults.standard.string(forKey: "useremail")!
        db.collection("users").document(userEmail).getDocument{ (document, error) in
            if let document = document, document.exists {
                self.clinicLabel.text = document.get("Clinic") as? String
                let num = document.get("Qnum") as! Int
                self.numLabel.text = String(num)
                db.collection("clinics").document(self.clinicLabel.text!).getDocument{ (document, error) in
                    if let document = document, document.exists {
                        let current = document.get("Currently Serving") as! Int
                        self.csLabel.text = "Currently Serving: " + String(current)
                        self.ewtLabel.text = "Estimated Waiting Time: \((num-current-1) * 15) min"
                    }
                }
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
