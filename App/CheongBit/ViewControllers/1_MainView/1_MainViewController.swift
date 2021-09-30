//
//  ViewController.swift
//  CheongBit
//
//  Created by 짜미 on 2021/08/20.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
// MARK: - 전역 변/상수
    
    // 경보 인식 스위치
    var switchONorOFF: Bool = false
    // 마이크 권한 상태
    var micPermissionStatus: Bool = true

// MARK: - Outlets
    
    @IBOutlet weak var locationSelectButton: mainViewNavButton!
    @IBOutlet weak var micSwitch: UIButton!
    @IBOutlet weak var micImage: UIImageView!
    @IBOutlet weak var micStatusLabel: UILabel!
    @IBOutlet weak var micONandOFFStackView: UIStackView!
    
    
// MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButtonUpdate()
        applyDynamicFont()
        requestMicrophonePermission()
        
        // 마이크 스텍뷰 디자인
        micONandOFFStackView.backgroundColor = #colorLiteral(red: 0, green: 0.4877254963, blue: 1, alpha: 1)
        micONandOFFStackView.layer.cornerRadius = micONandOFFStackView.frame.width/15
        micONandOFFStackView.layer.masksToBounds = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        locationSelectButton.setTitle("주소를 선택해주세요  ⌵", for: .normal)
        locationSelectButton.setTitle(otherViewLocationData, for: .normal)
    }

// MARK: - Actions
    
    // 주소설정버튼
    @IBAction func locationSelectbuttonTapped(_ sender: UIButton) {
        print("locationButtonTapped")
    }
    
    // 마이크 스위치 버튼
    @IBAction func switchChanged(_ sender: UIButton) {
        if micPermissionStatus == false {
            switchONorOFF = true
            switchButtonUpdate()
        }
        switchButtonUpdate()
    }
    
    // 신고버튼
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        
    }
    
// MARK: - Functions
    
    // 마이크 스위치 함수
    func switchButtonUpdate() {
        // 스위치가 꺼져있을 때
        if switchONorOFF == true{
            if micPermissionStatus == false {
                micCanceldAlert()
            }
            micSwitch.setImage(UIImage(named: "switchOn"), for: .normal)
            micImage.image = UIImage(named: "micOn")
            micStatusLabel.text = "화재경보음 인식 중"
            switchONorOFF = false
        }
        // 스위치가 켜져있을 때
        else {
            micSwitch.setImage(UIImage(named: "switchOff"), for: .normal)
            micImage.image = UIImage(named: "micOff")
            micStatusLabel.text = "인식 중이 아님"
            switchONorOFF = true
        }
    }
    
    // 다이나믹 폰트
    func applyDynamicFont() {
        locationSelectButton.titleLabel?.dynamicFont(fontSize: 20, weight: .regular)
        micStatusLabel.dynamicFont(fontSize: 24, weight: .bold)
    }
    
    // 마이크 권한
    func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Mic: 권한 허용")
                self.micPermissionStatus = true
            } else {
                print("Mic: 권한 거부")
                self.micPermissionStatus = false
            }
        })
    }
    
    func micCanceldAlert() {
        let micCanceled = UIAlertController(title: "마이크 권한 요청", message: "마이크 권한이 거절 되었습니다.\n설정>CheongBit 에서 허용 해주세요.", preferredStyle: UIAlertController.Style.alert)
        let alertCancel = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel)
        let goToSetting = UIAlertAction(title: "설정 가기", style: UIAlertAction.Style.default)
        
        micCanceled.addAction(alertCancel)
        micCanceled.addAction(goToSetting)
        
        self.present(micCanceled, animated: true)
    }
    
}

