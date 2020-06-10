//
//  AnnouncementsViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 31/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit

class AnnouncementsViewController: UIViewController {

    @IBOutlet weak var announcementsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadText(announcementsText)
    }
    
    func loadText(_ textView: UITextView) {
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = true
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
