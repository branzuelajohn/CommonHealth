//
//  HomeViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 25/5/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import SideMenu
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var viewQTicket: UIButton!
    @IBOutlet weak var clinicImage: UIImageView!
    @IBOutlet weak var aptLabel: UILabel!
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
   
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    func setUpUI() {
        topView.layer.cornerRadius = 25
        Utilities.styleFilledButton(searchButton)
        searchButton.titleLabel?.font = UIFont(name: "Futura-Bold", size: 15)
        Utilities.styleFilledButton(self.viewQTicket)
        self.viewQTicket.titleLabel?.font = UIFont(name: "Futura-Bold", size: 20)
        
        let db = Firestore.firestore()
        let email = UserDefaults.standard.string(forKey: "useremail")!
        db.collection("users").document(email).getDocument{ (document, error) in
            if let document = document, document.exists {
                let aptDate = document.get("Appointment Date") as? String
                let aptLoc = document.get("Appointment Location") as? String
                if (aptDate != nil && aptLoc != nil){
                    self.aptLabel.text = "Location: " + aptLoc! + "\n" + "Date: " + aptDate!
                    self.clinicImage.image = UIImage(named: aptLoc!)
                } else if (aptDate == nil) {
                    print("aptDate")
                } else {
                    print("aptLoc")
                }
                let inQueue = document.get("In Queue") as! Bool
                if (inQueue == false) {
                    self.viewQTicket.isEnabled = false
                    self.viewQTicket.alpha = 0
                } else {
                    self.viewQTicket.alpha = 1
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    class MenuListController: UITableViewController {
        var items = ["Edit Profile","Logout"]
        
        let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configureTableView()
        }
        
        
        func configureTableView() {
            tableView.backgroundColor = darkColor
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            tableView.rowHeight = 80
            /*tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true*/
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = items[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.backgroundColor = darkColor
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            // do something
            if indexPath.row == 0 {
                // do something
                print("Profile")
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextView = storyboard.instantiateViewController(withIdentifier: "ProfilePageViewController")
                self.navigationController?.present(nextView, animated: true)
            } else if indexPath.row == 1 {
                print("Logout")
                self.setuplogout()
            } else {
                //do something
            }
            
        }
        
        // TO IMPROVE
        func setuplogout() {
            
            //self.navigationController?.popToRootViewController(animated: true)
            do {
                try Auth.auth().signOut()
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeView = storyboard.instantiateViewController(withIdentifier: "ViewController")
                self.navigationController?.pushViewController(homeView, animated: true)
                //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out: ", signOutErr)
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
