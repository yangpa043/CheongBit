//
//  ReportDetail.swift
//  GOYO
//
//  Created by 짜미 on 2021/09/13.
//

import UIKit
import MessageUI
import CoreLocation
import Alamofire
import SwiftyJSON
import CoreMIDI

class ReportDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    // 신고 메시지 내용
    var reportContent: String = "신고 앱을 이용한 긴급신고입니다.\n"
    // 위치 선택 테이블뷰 셀 선택 Bool 값
    var locationSelected: Bool = false
    // 신고 타입 선택 완료 Bool 값
    var reportTypeSelected: Bool = false
    // 신고 타입 중 화재 신고 클릭
    var fireReportTypeSelected: Bool = false
    // 신고 타입 중 구조,구급 신고 클릭
    var rescueReportTypeSelected: Bool = true
    // 위치 셀 선택 Int
    var selectLocationNumber: Int = 0
    // 현위치 신고
    let currentLocManger = CLLocationManager()
    var latitude: Double = 0.0 // 위도
    var longitude: Double = 0.0 // 경도
    
    // MARK: - Outlets
    
    @IBOutlet weak var locationContentTitle: UILabel!
    @IBOutlet weak var reportContentTitle: UILabel!
    @IBOutlet weak var locationInfoButton: UIButton!
    @IBOutlet weak var fireReportTypeButton: UIButton!
    @IBOutlet weak var rescueReportTypeButton: UIButton!
    @IBOutlet weak var reportButton: reportButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    //tableViewOutlets
    @IBOutlet weak var locationShowTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // ⚠️걱정마세유 지금은 119로 신고 안갑니다.
    @IBOutlet weak var dontWorryLabel: UILabel!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 높이 조정 코드
        DispatchQueue.main.async {
            self.tableViewHeight.constant = self.locationShowTableView.contentSize.height
        }
        
        SelectedLocData.location.insert(Location(location: "위치서비스를 받을 수 없습니다.", locationDetail: "", locationName: "현위치"), at: 0)
        
        self.indicator.isHidden = true
        
        self.locationShowTableView.delegate = self
        self.locationShowTableView.dataSource = self
        locationShowTableView.layer.cornerRadius = 5.0
        
        currentLocManger.delegate = self
        currentLocManger.desiredAccuracy = kCLLocationAccuracyBest
        currentLocManger.distanceFilter = 2
        
        applyDynamicfont()
        reportButton.isEnabled = false
        locationShowTableView.isHidden = true
        
        rescueReportTypeTapped()
        fireReportTypeTapped()
        reportTypeButtonsTapped()
        
        // 라디오 버튼 디자인
        fireReportTypeButton.setTitle("  화재가 발생하였습니다.",for: .normal)
        rescueReportTypeButton.setTitle("  구조/구급이 필요합니다.", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationShowTableView.reloadData()
        
        if CLLocationManager.locationServicesEnabled() { // 위치서비스 권한 체크
            currentLocManger.startUpdatingLocation()
        } else {
            print("위치서비스가 꺼져있어요")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        currentLocManger.stopUpdatingLocation()
        
        // 현위치 cell 삭제하기
        if (SelectedLocData.location.firstIndex(where: { $0.locationName == "현위치" }) != nil) {
            SelectedLocData.location.removeAll(where: { $0.locationName == "현위치"})
        }
    }
    
    // MARK: - Actions
    
    // 장소를 선택해 주세요 버튼 눌렸을 때
    @IBAction func locationSelectTapped(_ sender: UIButton) {
        
        if locationShowTableView.isHidden == true { // 테이블뷰 on
            locationShowTableView.isHidden = false
            dontWorryLabel.isHidden = true
        } else { // 테이블뷰 off
            locationShowTableView.isHidden = true
            dontWorryLabel.isHidden = false
        }
    }
    
    // 화재 신고 타입 버튼 눌렸을 때
    @IBAction func fireReportTypeButtonTapped(_ sender: Any) {
        fireReportTypeTapped()
        reportTypeButtonsTapped()
    }
    
    // 구조,구급 신고 타입 버튼 눌렸을 때
    @IBAction func rescueReportTypeButtonTapped(_ sender: Any) {
        rescueReportTypeTapped()
        reportTypeButtonsTapped()
    }
    
    // 신고 버튼 눌렸을 때
    @IBAction func reportButtonTapped(_ sender: Any) {
        
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        
        decideReportContent()
        
        // 메시지가 안 보내졌을 때 앱을 죽지 않도록 하는 가드
        guard MFMessageComposeViewController.canSendText() else {
            print("SMS services are not available")
            return
        }
        
        let composeViewController = MFMessageComposeViewController()
        
        composeViewController.messageComposeDelegate = self
        composeViewController.recipients = ["01057686469"]
        composeViewController.body = reportContent
        present(composeViewController, animated: true, completion: nil)
        
    }
    
    
    // MARK: - functions
    
    // 폰 크기에 따라서 폰트 바뀌는 함수
    func applyDynamicfont() {
        locationContentTitle.dynamicFont(fontSize:30 , weight: .semibold)
        locationInfoButton.titleLabel?.dynamicFont(fontSize: 24, weight: .thin)
        reportContentTitle.dynamicFont(fontSize: 30, weight: .semibold)
        rescueReportTypeButton.titleLabel?.dynamicFont(fontSize: 24, weight: .thin)
        fireReportTypeButton.titleLabel?.dynamicFont(fontSize: 24, weight: .thin)
    }
    
    func stopIndicator() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
    }
    
    func rescueReportTypeTapped() {
        if rescueReportTypeSelected == false {
            rescueReportTypeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            rescueReportTypeSelected = true
            
        } else {
            rescueReportTypeButton.setImage(UIImage(systemName: "square"), for: .normal)
            rescueReportTypeSelected = false
        }
    }
    
    func fireReportTypeTapped() {
        if fireReportTypeSelected == false {
            fireReportTypeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            fireReportTypeSelected = true
            
        } else {
            fireReportTypeButton.setImage(UIImage(systemName: "square"), for: .normal)
            fireReportTypeSelected = false
        }
    }
    
    // 체크박스 버튼으로 신고 타입 선택
    func reportTypeButtonsTapped() {
        
        if fireReportTypeSelected == true && rescueReportTypeSelected == true || fireReportTypeSelected == false && rescueReportTypeSelected == true || fireReportTypeSelected == true && rescueReportTypeSelected == false {
            reportTypeSelected = true
            if reportTypeSelected == true && locationSelected == true {
                reportButton.isEnabled = true
            }
        } else {
            reportTypeSelected = false
            if reportTypeSelected == false && locationSelected == true {
                reportButton.isEnabled = false
            }
        }
        
    }
    
    // 화재 신고 내용 입력 함수
    func decideReportContent() {
        let appReportText = "- 앱을 이용한 긴급신고입니다 -\n"
        let fireString = "\n[화재 발생]"
        let rescueString = "\n[구조,구급 필요]"
        
        reportContent = appReportText
        
        reportContent += "\(SelectedLocData.location[selectLocationNumber].location) \(SelectedLocData.location[selectLocationNumber].locationDetail)"
        
        if fireReportTypeSelected == true {
            reportContent += fireString
        }
        
        if rescueReportTypeSelected == true {
            reportContent += rescueString
        }
    }
    
    // 현위치 좌표 조회 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didCheckCurrentLocation")
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            doSearchLocationCoordinates(latitude: latitude, longitude: longitude)
        }
    }
    
    // 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // 좌표 주소편환 api 함수
    func doSearchLocationCoordinates(latitude: Double, longitude: Double) {
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK cfb37488fa79ab6fb481894551bb3e79"
        ]
        
        let parameters: [String: Any] = [
            "x": longitude,
            "y": latitude,
            "input_coord": "WGS84"
        ]
        
        AF.request("https://dapi.kakao.com/v2/local/geo/coord2address.json", method: .get, parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case.success(let value): // api 성공
                if JSON(value)["documents"].arrayValue.count > 0, let Location = JSON(value)["documents"][0]["address"]["address_name"].string { // api값이 있을 경우
                    print("좌표주소: \(Location)")
                    SelectedLocData.location[0].location = Location
                    self.locationShowTableView.reloadData()
                } else { // 값이 없을 경우
                    print("non value")
                }
            case.failure(let error): // api 실패
                print(error)
            }
        })
        
    }
    
    // 메시지 전송 변수 차단 케이스 함수
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            stopIndicator()
            print("cancelled")
            reportContent = "신고 앱을 이용한 긴급신고입니다.\n"
            dismiss(animated: true, completion: nil)
            
        case .sent:
            stopIndicator()
            print("sent message:", controller.body ?? "")
            reportContent = "신고 앱을 이용한 긴급신고입니다.\n"
            dismiss(animated: true, completion: nil)
            reportSuccessAlert()
            
        case .failed:
            stopIndicator()
            print("failed")
            reportContent = "신고 앱을 이용한 긴급신고입니다.\n"
            dismiss(animated: true, completion: nil)
            
        @unknown default:
            stopIndicator()
            print("unkown Error")
            reportContent = "신고 앱을 이용한 긴급신고입니다.\n"
            dismiss(animated: true, completion: nil)
        }
    }
    
    func reportSuccessAlert() {
        let micCanceled = UIAlertController(title: "신고가 완료되었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
        let alertCancel = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel)
        { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        micCanceled.addAction(alertCancel)
        
        self.present(micCanceled, animated: true)
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SelectedLocData.location.count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationShowCell", for: indexPath) as! ReportDetailTableViewCell
        let location = SelectedLocData.location[indexPath.row]
        
        cell.locationNameLabel.text = location.locationName
        cell.locationLabel.text = "\(location.location) \(location.locationDetail)"
        cell.locationLabel.dynamicFont(fontSize: 17, weight: .regular)
        cell.locationNameLabel.dynamicFont(fontSize: 24, weight: .regular)
        
        return cell
    }
    
    var selectedRow : [Int] = [] {
        didSet {
            var myString = ""
            _ = selectedRow.map{ myString += "\($0)" }
            let myInt = Int(myString)
            locationInfoButton.setTitle("\(SelectedLocData.location[myInt!].locationName)  ⌵", for: .normal)
            selectLocationNumber = myInt!
        }
    }
    
    // 셀이 클릭 되었을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = [indexPath.row]
        
        locationShowTableView.isHidden = true
        locationSelected = true
        
        if reportTypeSelected == true, locationSelected == true {
            
            reportButton.isEnabled = true
        }
    }
}
