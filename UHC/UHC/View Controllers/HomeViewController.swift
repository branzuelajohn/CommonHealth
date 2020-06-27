//
//  HomeViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 25/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        
        menu = SideMenuNavigationController(rootViewController: UIViewController())
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    func setUpUI() {
        topView.layer.cornerRadius = 25
        Utilities.styleFilledButton(searchButton)
        searchButton.titleLabel?.font = UIFont(name: "Futura-Bold", size: 15)
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
