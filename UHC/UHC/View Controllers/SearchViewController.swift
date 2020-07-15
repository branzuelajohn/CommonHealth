//
//  SearchViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 17/6/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import os.log
import Firebase

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var clinicTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    let db = Firestore.firestore()
    var clinicArray = [String]()
    var searchClinic = [String()]
    var searching = false
    
    override func viewDidLoad() {
        retrieveClinic()
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        topView.layer.cornerRadius = CGFloat(25)
        topView.clipsToBounds = true
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func retrieveClinic() {
        db.collection("clinics").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.clinicArray.append(document.documentID)
                }
                self.clinicTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchClinic.count
        } else {
            return clinicArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching {
            cell?.textLabel?.text = searchClinic[indexPath.row]
        } else {
            cell?.textLabel?.text = clinicArray[indexPath.row]
        }
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchClinic = clinicArray.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        clinicTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text=""
        clinicTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let clinicDetailViewController = segue.destination as? ClinicViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedClinicCell = sender as? ClinicTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = clinicTableView.indexPath(for: selectedClinicCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedClinic = clinicArray[indexPath.row]
        clinicDetailViewController.clinic = Clinic(name: selectedClinic, photo: UIImage(named: selectedClinic), description: "")
    }
}
