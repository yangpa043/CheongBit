//
//  LocationSelectViewController.swift
//  GOYO
//
//  Created by 권은세 on 2021/09/07.
//

import UIKit

protocol LocationSearchResultDelegate {
    func didSelectLocation(selectedLocation: SearchLocation?)
}

class LocationSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    // 선택된 Row의 번호
    var myInt: Int?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var SelectedLocListTable: UITableView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.SelectedLocListTable.delegate = self
        self.SelectedLocListTable.dataSource = self
        
        applyDynamicFont()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.SelectedLocListTable.reloadData()
    }
    
    
    // MARK: - Actions
    
    //뒤로가기 버튼
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = SelectedLocListTable.isEditing
        SelectedLocListTable.setEditing(tableViewEditingMode, animated: true)
    }
    
    
    // MARK: - Functions
    
    func applyDynamicFont() {
        
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectedLocData.shared.location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationsTableViewCell
        let location = SelectedLocData.shared.location[indexPath.row]
        
        cell.locationNameLabel.text = location.name
        cell.locationLabel.text = location.location
        cell.showsReorderControl = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LocAddEditViewController") as! LocAddEditViewController
        vcName.locationName = SelectedLocData.shared.location[indexPath.row].location
        vcName.locationDetail = SelectedLocData.shared.location[indexPath.row].locationDetail
        vcName.locationNickname = SelectedLocData.shared.location[indexPath.row].name
        vcName.modalTransitionStyle = .coverVertical
        self.present(vcName, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SelectedLocData.shared.location.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            
        }
    }
    
}
