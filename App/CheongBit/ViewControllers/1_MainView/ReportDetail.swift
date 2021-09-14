//
//  ReportDetail.swift
//  CheongBit
//
//  Created by 짜미 on 2021/09/13.
//

import UIKit
import DLRadioButton
import MessageUI

class ReportDetail: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var reportContent:String = ""

    //MARK: - Outlets
    
    @IBOutlet weak var placeContentTitle: UILabel!
    @IBOutlet weak var reportContentTitle: UILabel!
    @IBOutlet weak var fireReportButton: DLRadioButton!
    @IBOutlet weak var rescueReportButton: DLRadioButton!
    @IBOutlet weak var reportButton: reportButton!
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDynamicfont()
        
        reportButton.isEnabled = false
        
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
    
    @IBAction func radioButtonTapped(_ sender: Any) {
        if fireReportButton.isSelected {
            reportButton.isEnabled = true
        } else if rescueReportButton.isSelected {
            reportButton.isEnabled = true
        }
    }
    
    
    // MARK: - functions
    
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
    
    func applyDynamicfont() {
        placeContentTitle.dynamicFont(fontSize: 40, weight: .bold)
        reportContentTitle.dynamicFont(fontSize: 40, weight: .bold)
        rescueReportButton.titleLabel?.dynamicFont(fontSize: 31, weight: .regular)
        fireReportButton.titleLabel?.dynamicFont(fontSize: 31, weight: .regular)
        reportButton.titleLabel?.dynamicFont(fontSize: 55, weight: .bold)
    }

}
