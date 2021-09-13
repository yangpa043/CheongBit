//
//  ViewController.swift
//  CheongBit
//
//  Created by 짜미 on 2021/08/20.
//

import UIKit
import MessageUI

class MainViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var switchONorOFF:Bool = false

    // MARK: - Outlets
    @IBOutlet weak var micSwitch: UIButton!
    @IBOutlet weak var micImage: UIImageView!
    @IBOutlet weak var micStatusLabel: UILabel!
    @IBOutlet weak var micONandOFFStackView: UIStackView!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButtonUpdate()
        
        // 마이크 스텍뷰 디자인
        micONandOFFStackView.backgroundColor = #colorLiteral(red: 0, green: 0.4877254963, blue: 1, alpha: 1)
        micONandOFFStackView.layer.cornerRadius = micONandOFFStackView.frame.width/15
        micONandOFFStackView.layer.masksToBounds = false
    }

// MARK: - Actions
    
    // 주소설정버튼
    @IBAction func locationSelectbuttonTapped(_ sender: UIButton) {
        print("locationButtonTapped")
    }
    
    // 마이크 스위치 버튼
    @IBAction func switchChanged(_ sender: UIButton) {
        switchButtonUpdate()
    }
    
    // 신고버튼
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        
//        // 메시지가 안 보내졌을 때 앱을 죽지 않도록 하는 가드
//        guard MFMessageComposeViewController.canSendText() else {
//            print("SMS services are not available")
//            return
//        }
//
//        let composeViewController = MFMessageComposeViewController()
//
//        composeViewController.messageComposeDelegate = self
//        composeViewController.recipients = ["01048227008"]
//        composeViewController.body = "Report"
//        present(composeViewController, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    // 마이크 스위치 함수
    func switchButtonUpdate() {
        if switchONorOFF == true{
            micSwitch.setImage(UIImage(named: "switchOn"), for: .normal)
            micImage.image = UIImage(named: "micOn")
            micStatusLabel.text = "소리 인식 중"
            switchONorOFF = false
        } else {
            micSwitch.setImage(UIImage(named: "switchOff"), for: .normal)
            micImage.image = UIImage(named: "micOff")
            micStatusLabel.text = "인식 중이 아님"
            switchONorOFF = true
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
    
}

