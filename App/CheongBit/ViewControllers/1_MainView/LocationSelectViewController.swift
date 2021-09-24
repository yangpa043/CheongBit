//
//  LocationSelectViewController.swift
//  CheongBit
//
//  Created by 권은세 on 2021/09/07.
//

import UIKit
//import "CheongBit_Swift.h"

class LocationSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
// MARK: - 전역 변/상수
    
    let data = LocationDummyData.shared.location
    var dataToMove: String = ""
    
// MARK: - Outlets
    
    @IBOutlet weak var locationEnterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDynamicFont()
    }
    
    //뒤로가기 버튼
    @IBAction func backButtonTapped(_ sender: Any) {
        moveToMainVC()
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
    
    var selectedRow : [Int] = [] {
        didSet {
            var myString = ""
            _ = selectedRow.map{ myString += "\($0)" }
            let myInt = Int(myString)
            dataToMove = "\(data[myInt!].name)  ⌵"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = [indexPath.row]
        otherViewLocationData = "\(dataToMove)"
        dismiss(animated: true, completion: nil)
    }
    
    // 메인뷰로 주소 데이터 전달
    func moveToMainVC() {
//        let MainVC = UIStoryboard(name: "1_MainTab", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        //let mainVC = MainViewController()
        //mainVC.otherViewLocationData = dataToMove
        //print(MainVC.otherViewLocationData)
        //self.present(MainVC, animated: false, completion: nil)
    }
    
}
