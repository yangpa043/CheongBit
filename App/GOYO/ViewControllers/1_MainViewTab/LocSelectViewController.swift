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
    
    @IBOutlet weak var locationEnterLabel: UILabel!
    @IBOutlet weak var SelectedLocListTable: UITableView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // MARK: - Functions
    
    func applyDynamicFont() {
        locationEnterLabel.dynamicFont(fontSize: 35, weight: .regular)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
