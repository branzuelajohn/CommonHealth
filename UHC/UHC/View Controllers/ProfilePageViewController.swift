//
//  ProfilePageViewController.swift
//  UHC
//
//  Created by John Branzuela on 24/7/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
private let reuseIdentifier = "SettingsCell"


class ProfilePageViewController: UIViewController {

       // MARK: - Properties
        
        var tableView: UITableView!
        var userInfoHeader: UserInfoHeader!
        
        // MARK: - Init

        override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
        }

        // MARK: - Helper Functions
        
        func configureTableView() {
            tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            
            tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
            view.addSubview(tableView)
            tableView.frame = view.frame
            
            let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
            userInfoHeader = UserInfoHeader(frame: frame)
            tableView.tableHeaderView = userInfoHeader
            tableView.tableFooterView = UIView()
        }
        
        func configureUI() {
            configureTableView()
            
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
            navigationItem.title = "Settings"
        }

    }

    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
            return cell
        }
        
        
    }


    

  
