//
//  ViewController.swift
//  CheongBit
//
//  Created by 짜미 on 2021/08/20.
//

import UIKit

class MainViewController: UIViewController {
    
// MARK: - 전역 변/상수
    
    var switchONorOFF: Bool = false
    //var otherViewLocationData: String = ""

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
        //locationSelectButton.setTitle("주소를 선택해주세요  ⌵", for: .normal)
        
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
        switchButtonUpdate()
    }
    
    // 신고버튼
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        
    }
    
// MARK: - Functions
    
    // 마이크 스위치 함수
    func switchButtonUpdate() {
        if switchONorOFF == true{
            micSwitch.setImage(UIImage(named: "switchOn"), for: .normal)
            micImage.image = UIImage(named: "micOn")
            micStatusLabel.text = "화재경보음 인식 중"
            switchONorOFF = false
        } else {
            micSwitch.setImage(UIImage(named: "switchOff"), for: .normal)
            micImage.image = UIImage(named: "micOff")
            micStatusLabel.text = "인식 중이 아님"
            switchONorOFF = true
        }
    }
    
    func applyDynamicFont() {
        locationSelectButton.titleLabel?.dynamicFont(fontSize: 20, weight: .regular)
        micStatusLabel.dynamicFont(fontSize: 24, weight: .bold)
    }
}

