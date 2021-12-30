//
//  LocationSearchViewController.swift
//  GOYO
//
//  Created by 짜미 on 2021/11/11.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Network

class LocSearchViewController: UIViewController, ResultCellDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    private var resultList = [SearchLocation]()
    var delegate: LocationSearchResultDelegate?
    // 네트워크 연결 여부 bool 값
    var checkNetworkValue: Bool = false
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var textFieldLoc: UITextField!
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkNetworkStart()
        
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLocationNotification(_:)), name: NSNotification.Name("receivedLocation"), object: nil)
        
        self.indicator.isHidden = true
        
        self.resultList.removeAll()
        
        self.resultTable.delegate = self
        self.resultTable.dataSource = self
    }
    
    
    // MARK: - Actions
    
    // Back 버튼
    @IBAction func xButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SearchButtonTapped(_ sender: Any) {
        
        if checkNetworkValue == true{
            doSearch()
        } else {
            let cantConnectNetwork = UIAlertController(title: "네트워크가 연결되어 있지 않아요.", message: "네트워크 연결 후 다시 시도해주세요.", preferredStyle: UIAlertController.Style.alert)
            let alertCancel = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel)
            
            cantConnectNetwork.addAction(alertCancel)
            
            self.present(cantConnectNetwork, animated: true)
        }
        
    }
    
    @IBAction func keyboardDoneButtonTapped(_ sender: Any) {
        doSearch()
    }
    
    
    // MARK: - Functions
    
    // 주소 선택 후 LocAddEditVC에 데이터 보내는 노티
    @objc func didRecieveLocationNotification(_ notification: Notification) {
        print("receivedLocation 받았음")
        guard let location: String = notification.userInfo?["Location"] as? String else { return }
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LocAddEditViewController") as! LocAddEditViewController
        vcName.locationName = location
        vcName.modalTransitionStyle = .coverVertical
        self.present(vcName, animated: true, completion: nil)
    }
    
    // 네트워크 연결 여부 함수
    let monitor = NWPathMonitor()
    func checkNetworkStart() {
        self.monitor.start(queue: DispatchQueue.global())
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied { // 네트워크가 연결된 경우
                print("[Network Connected]")
                self.checkNetworkValue = true
            } else { // 네트워크가 연결되지 않은 경우
                print("[Network Not Connected]")
                self.checkNetworkValue = false
            }
        }
    }
    
    // rest api 검색
    func doSearchLocation(keyword: String, page: Int) {
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK cfb37488fa79ab6fb481894551bb3e79"
        ]
        
        let parameters: [String: Any] = [
            "query": keyword,
            "page": page,
            "size": 20
        ]
        
        AF.request("https://dapi.kakao.com/v2/local/search/address.json", method: .get, parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            switch response.result {
            case .success(let value):
                print(response.result)
                print("total_count : \(JSON(value)["meta"]["total_count"])")
                print("is_end : \(JSON(value)["meta"]["is_end"])")
                print("documents : \(JSON(value)["documents"])")
                
                if let LocationList = JSON(value)["documents"].array {
                    for item in LocationList {
                        
                        let LocationName = item["address_name"].string ?? ""
                        let jibunLocation = item["address"]["address_name"].string ?? "지번 주소 없음"
                        let roadLocation = item["road_address"]["address_name"].string ?? "도로명 주소 없음"
                        let depthOneName = self.generateDeptFirstLoc(loc: item["address"]["region_1depth_name"].string ?? "")
                        let depthTwoName = item["address"]["region_2depth_name"].string ?? ""
                        let depthThreeName = item["address"]["region_3depth_name"].string ?? ""
                        
                        self.resultList.append(SearchLocation(locationName: LocationName, roadLoc: roadLocation, jibunLoc: jibunLocation, depthOneLoc: depthOneName, deptTwoLoc: depthTwoName, deptThreeLoc: depthThreeName))
                    }
                }
                
                if self.resultList.isEmpty == true {
                    let noResult = UIAlertController(title: "검색 결과가 없습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                    let alertCancel = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel)
                    
                    noResult.addAction(alertCancel)
                    
                    self.present(noResult, animated: true)
                }
                
                self.resultTable.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func doSearch() {
        self.resultList.removeAll()
        
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        
        self.doSearchLocation(keyword: textFieldLoc.text ?? "" , page: 0)
        self.view.endEditing(true)
        
    }
    
    private func generateDeptFirstLoc(loc: String) -> String {
        switch(loc) {
        case "서울":
            return "서울특별시"
        case "대전", "인천", "부산", "광주", "울산", "대구":
            return "\(loc)광역시"
        case "경기", "제주", "강원":
            return "\(loc)도"
        case "충남":
            return "충청남도"
        case "충북":
            return "충청북도"
        case "경남":
            return "경상남도"
        case "전남":
            return "전라남도"
        case "전북":
            return "전라북도"
        case "경북":
            return "경상북도"
        default:
            return "Unknown"
        }
    }
    
    
    // MARK: - tableView Delegate
    
    func didSelectOK(didSelectItem: SearchLocation?) {
        print("selected : \(didSelectItem?.locationName ?? "unknown")")
        delegate?.didSelectLocation(selectedLocation: didSelectItem)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! LocSearchTableViewCell
        print(self.resultList[indexPath.row].locationName)
        cell.item = self.resultList[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
}
