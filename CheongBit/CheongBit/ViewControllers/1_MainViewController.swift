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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButtonUpdate()
    }

// MARK: - Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("locationButtonTapped")
    }
    
    @IBAction func switchChanged(_ sender: UIButton) {
        switchButtonUpdate()
    }
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        
        // 메시지가 안 보내졌을 때 앱을 죽지 않도록 하는 가드
        guard MFMessageComposeViewController.canSendText() else {
            print("SMS services are not available")
            return
        }
        
        let composeViewController = MFMessageComposeViewController()
        
        composeViewController.messageComposeDelegate = self
        composeViewController.recipients = ["01048227008"]
        composeViewController.body = "Report"
        present(composeViewController, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    // 마이크 스위치 함수
    func switchButtonUpdate() {
        if switchONorOFF == true{
            micSwitch.setImage(UIImage(named: "switchOn"), for: .normal)
            micImage.image = UIImage(named: "micOn")
            switchONorOFF = false
        } else {
            micSwitch.setImage(UIImage(named: "switchOff"), for: .normal)
            micImage.image = UIImage(named: "micOff")
            switchONorOFF = true
        }
    }
    
    // 신고하기 버튼 변수 차단 케이스 함수
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
    
    //
}

