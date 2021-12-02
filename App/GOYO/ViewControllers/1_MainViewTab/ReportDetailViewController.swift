//
//  ReportDetail.swift
//  GOYO
//
//  Created by 짜미 on 2021/09/13.
//

import UIKit
import MessageUI

class ReportDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - VC let/var
    
    // 위치데이터 shared
    let data = LocationDummyData.shared.location
    // 신고 메시지 내용
    var reportContent: String = ""
    // 위치 선택 테이블뷰 표시 Bool 값
    var locationSelectIsHidden: Bool = true
    // 위치 선택 테이블뷰 셀 선택 Bool 값
    var locationSelected: Bool = false
    // 신고 타입 선택 완료 Bool 값
    var reportTypeSelected: Bool = false
    // 신고 타입 중 화재 신고 클릭
    var fireReportTypeSelected: Bool = false
    // 신고 타입 중 구조,구급 신고 클릭
    var rescueReportTypeSelected: Bool = false
    // 위치 셀 선택 Int
    var selectLocationNumber:Int = 0
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var placeContentTitle: UILabel!
    @IBOutlet weak var reportContentTitle: UILabel!
    @IBOutlet weak var locationInfoButton: UIButton!
    @IBOutlet weak var fireReportTypeButton: UIButton!
    @IBOutlet weak var rescueReportTypeButton: UIButton!
    @IBOutlet weak var reportButton: reportButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    //tableViewOutlets
    @IBOutlet weak var locationShowTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    // MARK: - VCLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 높이 조정 코드
        DispatchQueue.main.async {
            self.tableViewHeight.constant = self.locationShowTableView.contentSize.height
        }
        
        self.indicator.isHidden = true
        
        self.locationShowTableView.delegate = self
        self.locationShowTableView.dataSource = self
        
        applyDynamicfont()
        reportButton.isEnabled = false
        locationShowTableView.isHidden = locationSelectIsHidden
        
        // 네비 바 백버튼 텍스트 수정
        self.navigationController?.navigationBar.topItem?.title = "홈"
        
        // 라디오 버튼 디자인
        fireReportTypeButton.setTitle("  화재 신고",for: .normal)
        rescueReportTypeButton.setTitle("  구조, 구급 신고", for: .normal)
    }
    
    
    // 이미 장소가 선택되어 있을 때 locationInfoButton의 텍스트 바꾸기
    override func viewWillAppear(_ animated: Bool) {
        if firstSelectRowNumber == nil {
            locationInfoButton.setTitle("장소를 선택해 주세요.  ⌵", for: .normal)
        } else {
            locationInfoButton.setTitle("\(data[firstSelectRowNumber!].name)  ⌵", for: .normal)
            locationSelected = true
            
        }
        
    }
    
    
    // MARK: - Actions
    
    // 장소를 선택해 주세요 버튼 눌렸을 때
    @IBAction func locationSelectTapped(_ sender: UIButton) {
        
        // 버튼 눌렀을때 테이블 뷰 꺼졋다 켜졋다
        if locationSelectIsHidden == true {
            locationSelectIsHidden = false
        } else {
            locationSelectIsHidden = true
        }
        
        locationShowTableView.isHidden = locationSelectIsHidden
    }
    
    // 화재 신고 타입 버튼 눌렸을 때
    @IBAction func fireReportTypeButtonTapped(_ sender: Any) {
        if fireReportTypeSelected == false {
            fireReportTypeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            fireReportTypeSelected = true
            
        } else {
            fireReportTypeButton.setImage(UIImage(systemName: "square"), for: .normal)
            fireReportTypeSelected = false
        }
        reportTypeButtonsTapped()
    }
    
    // 구조,구급 신고 타입 버튼 눌렸을 때
    @IBAction func rescueReportTypeButtonTapped(_ sender: Any) {
        if rescueReportTypeSelected == false {
            rescueReportTypeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            rescueReportTypeSelected = true
            
        } else {
            rescueReportTypeButton.setImage(UIImage(systemName: "square"), for: .normal)
            rescueReportTypeSelected = false
        }
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
        
        if fireReportTypeButton.isSelected {
            reportContent = "화재 신고"
        } else if rescueReportTypeButton.isSelected {
            reportContent = "구조, 구급 신고"
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
        placeContentTitle.dynamicFont(fontSize: 40, weight: .bold)
        reportContentTitle.dynamicFont(fontSize: 40, weight: .bold)
        rescueReportTypeButton.titleLabel?.dynamicFont(fontSize: 31, weight: .regular)
        fireReportTypeButton.titleLabel?.dynamicFont(fontSize: 31, weight: .regular)
        reportButton.titleLabel?.dynamicFont(fontSize: 55, weight: .bold)
    }
    
    func stopIndicator() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
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
    
    func decideReportContent() {
        let fireString = "\n화재 신고"
        let rescueString = "\n구조, 구급 신고"
        
        // 이미 주소가 선택되어 있을 때 메시지 내용 추가
        if locationSelected == true {
            if firstSelectRowNumber != nil {
                reportContent = data[firstSelectRowNumber!].location
            } else {
                reportContent = data[selectLocationNumber].location
            }
        }
        
        if fireReportTypeSelected == true {
            reportContent += fireString
        }
        
        if rescueReportTypeSelected == true {
            reportContent += rescueString
        }
        
    }
    
    // 메시지 전송 변수 차단 케이스 함수
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            stopIndicator()
            print("cancelled")
            reportContent = ""
            dismiss(animated: true, completion: nil)
            
        case .sent:
            stopIndicator()
            print("sent message:", controller.body ?? "")
            reportContent = ""
            dismiss(animated: true, completion: nil)
            reportSuccessAlert()
            
        case .failed:
            stopIndicator()
            print("failed")
            reportContent = ""
            dismiss(animated: true, completion: nil)
            
        @unknown default:
            stopIndicator()
            print("unkown Error")
            reportContent = ""
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
        data.count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationShowCell", for: indexPath) as! ReportDetailTableViewCell
        let location = data[indexPath.row]
        
        cell.locationNameLabel.text = location.name
        cell.locationLabel.text = location.location
        cell.locationLabel.dynamicFont(fontSize: 18, weight: .regular)
        cell.locationNameLabel.dynamicFont(fontSize: 24, weight: .regular)
        
        return cell
    }
    
    var selectedRow : [Int] = [] {
        didSet {
            var myString = ""
            _ = selectedRow.map{ myString += "\($0)" }
            let myInt = Int(myString)
            locationInfoButton.setTitle("\(data[myInt!].name)  ⌵", for: .normal)
            selectLocationNumber = myInt!
        }
    }
    
    // 셀이 클릭 되었을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        firstSelectRowNumber = nil
        
        selectedRow = [indexPath.row]
        
        locationSelectIsHidden = true
        locationSelected = true
        locationShowTableView.isHidden = locationSelectIsHidden
        
        if reportTypeSelected == true, locationSelected == true {
            
            reportButton.isEnabled = true
        }
    }
}
