//
//  ReportDetail.swift
//  CheongBit
//
//  Created by 짜미 on 2021/09/13.
//

import UIKit
import MessageUI

class ReportDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
// MARK: - 전역 변/상수
    
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

// MARK: - Outlets

    @IBOutlet weak var placeContentTitle: UILabel!
    @IBOutlet weak var reportContentTitle: UILabel!
    @IBOutlet weak var locationInfoButton: UIButton!
    @IBOutlet weak var fireReportTypeButton: UIButton!
    @IBOutlet weak var rescueReportTypeButton: UIButton!
    @IBOutlet weak var reportButton: reportButton!
    
    //tableViewOutlets
    @IBOutlet weak var locationShowTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
// MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 높이 조정 코드
        DispatchQueue.main.async {
            self.tableViewHeight.constant = self.locationShowTableView.contentSize.height
        }
        
        applyDynamicfont()
        
        reportButton.isEnabled = false
        locationShowTableView.isHidden = locationSelectIsHidden
        
        // 네비 바 백버튼 텍스트 수정
        self.navigationController?.navigationBar.topItem?.title = "홈"
        
        // 라디오 버튼 디자인
        fireReportTypeButton.setTitle("  화재 신고",for: .normal)
        rescueReportTypeButton.setTitle("  구조, 구급 신고", for: .normal)
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
        fireReportTypeButtonUpdate()
    }
    
    // 구조,구급 신고 타입 버튼 눌렸을 때
    @IBAction func rescueReportTypeButtonTapped(_ sender: Any) {
        rescueReportTypeButtonUpdate()
    }
    
    
    // 체크박스 버튼으로 신고 타입 선택
    @IBAction func reportTypeButtonsTapped(_ sender: Any) {
        
        print(fireReportTypeSelected, rescueReportTypeSelected)
        
//        if fireReportTypeSelected == true, rescueReportTypeSelected == true {
//            reportTypeSelected = true
//
//            if reportTypeSelected == true, locationSelected == true {
//                reportButton.isEnabled = true
//            }
//        }
//        else if fireReportTypeSelected == true, rescueReportTypeSelected == false {
//            reportTypeSelected = true
//
//            if reportTypeSelected == true, locationSelected == true {
//                reportButton.isEnabled = true
//            }
//        } else if fireReportTypeSelected == false, rescueReportTypeSelected == true {
//            reportTypeSelected = true
//
//            if reportTypeSelected == true, locationSelected == true {
//                reportButton.isEnabled = true
//            }
//        }
//        else if fireReportTypeSelected == false, rescueReportTypeSelected == false {
//            reportTypeSelected = false
//
//            if reportTypeSelected == false, locationSelected == true {
//                reportButton.isEnabled = false
//            }
//        }
        
    }
    
    // 신고 버튼 눌렸을 때
    @IBAction func reportButtonTapped(_ sender: Any) {
        
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
        composeViewController.recipients = ["01048227008"]
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
    
    // 화재 신고 타입 버튼 클릭
    func fireReportTypeButtonUpdate() {
        if fireReportTypeSelected == true {
            fireReportTypeSelected = false
            fireReportTypeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            
        } else if fireReportTypeSelected == false {
            fireReportTypeSelected = true
            fireReportTypeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
    
    // 구조,구급 신고 타입 버튼 클릭
    func rescueReportTypeButtonUpdate() {
        if rescueReportTypeSelected == true {
            rescueReportTypeSelected = false
            rescueReportTypeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            
        } else if rescueReportTypeSelected == false {
            rescueReportTypeSelected = true
            rescueReportTypeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
    
    // 메시지 전송 변수 차단 케이스 함수
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            switch result {
            case .cancelled:
                print("cancelled")
                dismiss(animated: true, completion: nil)
            case .sent:
                print("sent message:", controller.body ?? "")
                dismiss(animated: true, completion: nil)
            case .failed:
                print("failed")
                dismiss(animated: true, completion: nil)
            @unknown default:
                print("unkown Error")
                dismiss(animated: true, completion: nil)
            }
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
        }
    }
    
    // 셀이 클릭 되었을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = [indexPath.row]
        
        locationSelectIsHidden = true
        locationSelected = true
        locationShowTableView.isHidden = locationSelectIsHidden
        
        if reportTypeSelected == true, locationSelected == true {
            
            reportButton.isEnabled = true
        }
    }
}
