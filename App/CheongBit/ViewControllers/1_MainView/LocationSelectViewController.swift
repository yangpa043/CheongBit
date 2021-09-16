//
//  LocationSelectViewController.swift
//  CheongBit
//
//  Created by 권은세 on 2021/09/07.
//

import UIKit

class LocationSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
// MARK: - 전역함수
    let data = LocationDummyData.shared.location
    
// MARK: - Outlets
    @IBOutlet weak var locationEnterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDynamicFont()
    }
    
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationsTableViewCell
        let location = data[indexPath.row]

        cell.locationNameLabel.text = location.name
        cell.locationLabel.text = location.location

        return cell
    }
    
}
