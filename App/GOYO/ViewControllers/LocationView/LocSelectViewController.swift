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
    
    @IBOutlet weak var selectedLocListTable: UITableView!
    @IBOutlet weak var tableViewEditButton: UIBarButtonItem!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLocationEditCompleteNotification(_:)), name: NSNotification.Name("locationEditComplete"), object: nil)
        
        self.selectedLocListTable.delegate = self
        self.selectedLocListTable.dataSource = self
        selectedLocListTable.separatorInset.left = 0
        
        applyDynamicFont()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedLocListTable.reloadData()
    }
    
    
    // MARK: - Actions
    
    // tableView 편집버튼
    @IBAction func tableViewEdit(_ sender: Any) {
        if selectedLocListTable.isEditing {
            tableViewEditButton.title = "편집"
            selectedLocListTable.setEditing(false, animated: true)
        } else {
            tableViewEditButton.title = "완료"
            selectedLocListTable.setEditing(true, animated: true)
        }
    }
    
    
    
    // MARK: - Functions
    
    func applyDynamicFont() {
        
    }
    
    @objc func didLocationEditCompleteNotification(_ notification: Notification) {
        self.selectedLocListTable.reloadData()
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectedLocData.location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationsTableViewCell
        let location = SelectedLocData.location[indexPath.row]
        
        cell.locationNameLabel.text = location.name
        cell.locationLabel.text = "\(location.location) \(location.locationDetail)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LocAddEditViewController") as! LocAddEditViewController
        vcName.locationName = SelectedLocData.location[indexPath.row].location
        vcName.locationDetail = SelectedLocData.location[indexPath.row].locationDetail
        vcName.locationNickname = SelectedLocData.location[indexPath.row].name
        vcName.userSelectedRow = indexPath.row
        self.present(vcName, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SelectedLocData.location.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
