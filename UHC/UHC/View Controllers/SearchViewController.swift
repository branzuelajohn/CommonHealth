//
//  SearchViewController.swift
//  UHC
//
//  Created by Liu Xiaowen on 17/6/20.
//  Copyright © 2020 CommonHealth. All rights reserved.
//

import UIKit
import os.log

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var clinicTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    let clinicArray = [Clinic(name:"University Health Centre", photo: UIImage(named: "UHC"), description:nil),
                       Clinic(name:"Doctor W.K.Koo & Associates P.L.", photo:nil, description:nil)]
    
    var searchClinic = [Clinic?]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.cornerRadius = CGFloat(25)
        topView.clipsToBounds = true
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchClinic.count
        } else {
            return clinicArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicTableViewCell") as? ClinicTableViewCell else {
            fatalError("The dequeued cell is not an instance of ClinicTableViewCell.")
        }
        if searching {
            let clinic = searchClinic[indexPath.row]
            cell.nameLabel.text = clinic?.name
            cell.photoImageView.image = clinic?.photo
        } else {
            let clinic = clinicArray[indexPath.row]
            cell.nameLabel.text = clinic?.name
            cell.photoImageView.image = clinic?.photo
            
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Searching")
        searchClinic = clinicArray.filter({$0!.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
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
        clinicDetailViewController.clinic = selectedClinic
    }
}
