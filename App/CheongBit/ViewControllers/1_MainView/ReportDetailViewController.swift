//
//  ReportDetail.swift
//  CheongBit
//
//  Created by 짜미 on 2021/09/13.
//

import UIKit
import DLRadioButton
import MessageUI

class ReportDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var reportContent: String = ""
    var locationSelectIsHidden: Bool = true

    //MARK: - Outlets
    
    @IBOutlet weak var placeContentTitle: UILabel!
    @IBOutlet weak var reportContentTitle: UILabel!
    @IBOutlet weak var fireReportButton: DLRadioButton!
    @IBOutlet weak var rescueReportButton: DLRadioButton!
    @IBOutlet weak var reportButton: reportButton!
    
    //tableView
    @IBOutlet weak var locationShowTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    //MARK: - viewDidLoad
    
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
        fireReportButton.setTitle("화재 신고",for: .normal)
        rescueReportButton.setTitle("구조, 구급 신고", for: .normal)
        fireReportButton.iconSize = 23
        rescueReportButton.iconSize = 23
        fireReportButton.isIconOnRight = true
        rescueReportButton.isIconOnRight = true
        
    }
    
    //MARK: - Actions
    
    // 장소를 선택해 주세요 버튼
    @IBAction func locationSelectTapped(_ sender: UIButton) {
        
        // 버튼 눌렀을때 테이블 뷰 꺼졋다 켜졋다
        if locationSelectIsHidden == true {
            locationSelectIsHidden = false
        } else {
            locationSelectIsHidden = true
        }
        
        locationShowTableView.isHidden = locationSelectIsHidden
    }
    
    
    // 신고 내용 선택
    @IBAction func radioButtonTapped(_ sender: Any) {
        if fireReportButton.isSelected {
            reportButton.isEnabled = true
        } else if rescueReportButton.isSelected {
            reportButton.isEnabled = true
        }
    }
    
    // 신고 버튼 눌렸을 때
    @IBAction func reportButtonTapped(_ sender: Any) {
        
        // 메시지가 안 보내졌을 때 앱을 죽지 않도록 하는 가드
        guard MFMessageComposeViewController.canSendText() else {
            print("SMS services are not available")
            return
        }
        
        if fireReportButton.isSelected {
            reportContent = "화재 신고"
            print("화재 신고")
        } else if rescueReportButton.isSelected {
            reportContent = "구조, 구급 신고"
            print("구조, 구급 신고")
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
        rescueReportButton.titleLabel?.dynamicFont(fontSize: 31, weight: .regular)
        fireReportButton.titleLabel?.dynamicFont(fontSize: 31, weight: .regular)
        reportButton.titleLabel?.dynamicFont(fontSize: 55, weight: .bold)
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
        LocationDummyData.shared.location.count
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationShowCell", for: indexPath) as! ReportDetailTableViewCell
        let location = LocationDummyData.shared.location[indexPath.row]

        cell.locationNameLabel.text = location.name
        cell.locationLabel.text = location.location
        cell.locationLabel.dynamicFont(fontSize: 18, weight: .regular)
        cell.locationNameLabel.dynamicFont(fontSize: 24, weight: .regular)

        return cell
    }
}
