//
//  ViewController.swift
//  MessageFramework
//
//  Created by 짜미 on 2021/08/23.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        @IBAction func ReportTapped(_ sender: UIButton) {
            
            let composeViewController = MFMessageComposeViewController()
            
            guard MFMessageComposeViewController.canSendText() else {
                print("SMS services are not available")
                return
            }
            
            composeViewController.recipients = ["01048227008"]
            composeViewController.body = "신고합니다!"
            
            present(composeViewController, animated: true, completion: nil)
            
            extension ViewController: MFMessageComposeViewControllerDelegate {
                func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
                    switch result {
                    case .cancelled:
                        print("celled")
                        dismiss(animated: true, completion: nil)
                    case .sent:
                        print("sent message", controller.body ?? "")
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
            
            composeViewController
            
        }
}

