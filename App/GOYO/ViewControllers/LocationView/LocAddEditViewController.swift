//
//  LocAddEditViewController.swift
//  GOYO
//
//  Created by 짜미 on 2021/12/01.
//

import UIKit

class LocAddEditViewController: UIViewController {
    
    // MARK: - Variables
    
    var locationName: String?
    var locationDetail: String?
    var locationNickname: String?
    var location: Location?
    var userSelectedRow: Int?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locDetailLabel: UILabel!
    @IBOutlet weak var locDetailTextField: UITextField!
    @IBOutlet weak var locNicknameTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LabelTextDesign()
        
        if let locationName = locationName {
            print("받았다!", locationName)
            locationTextField.text = locationName
            locDetailTextField.text = locationDetail
            locNicknameTextField.text = locationNickname
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        completeButtonDisalbe()
    }
    
    // MARK: - Actions
    
    @IBAction func editCompleteButtonTapped(_ sender: Any) {
        
        appendCell()
        
    }
    
    @IBAction func keyboardDoneButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        completeButtonDisalbe()
    }
    
    @IBAction func checkEditing(_ sender: Any) {
        completeButtonDisalbe()
    }
    
    // MARK: - Functions
    
    // 도로명주소, 상세주소 필수 항목 표시 함수
    func LabelTextDesign() {
        guard let locationLabel = self.locationLabel.text else { return }
        guard let locDetailLabel = self.locDetailLabel.text else { return }
        
        let attributeLocation = NSMutableAttributedString(string: locationLabel)
        let attributeLocDetail = NSMutableAttributedString(string: locDetailLabel)
        
        let fontSize = UIFont.systemFont(ofSize: 24)
        
        attributeLocation.addAttribute(.foregroundColor, value: UIColor.red, range: (locationLabel as NSString).range(of: "*"))
        attributeLocDetail.addAttribute(.foregroundColor, value: UIColor.red, range: (locDetailLabel as NSString).range(of: "*"))
        attributeLocation.addAttribute(.font, value: fontSize, range: (locationLabel as NSString).range(of: "*"))
        attributeLocDetail.addAttribute(.font, value: fontSize, range: (locDetailLabel as NSString).range(of: "*"))
        
        self.locationLabel.attributedText = attributeLocation
        self.locDetailLabel.attributedText = attributeLocDetail
    }
    
    // 화면터치로 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func appendCell() {
        if let userSelectedRow = userSelectedRow { // 주소 편집 할 때에
            
            if locNicknameTextField.hasText == true {
                SelectedLocData.location[userSelectedRow].location = locationTextField.text!
                SelectedLocData.location[userSelectedRow].locationDetail = locDetailTextField.text!
                SelectedLocData.location[userSelectedRow].locationName = locNicknameTextField.text!
            } else {
                SelectedLocData.location[userSelectedRow].location = locationTextField.text!
                SelectedLocData.location[userSelectedRow].locationDetail = locDetailTextField.text!
                SelectedLocData.location[userSelectedRow].locationName = locationTextField.text!
            }
            
            
            NotificationCenter.default.post(name: NSNotification.Name("locationEditComplete"), object: nil)
            
            SelectedLocData.saveAllData()
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        } else { // 주소 추가 할 때에
            if locNicknameTextField.hasText == true {
                SelectedLocData.location.insert(Location(location: "\(self.locationTextField.text ?? "")", locationDetail: "\(self.locDetailTextField.text ?? "")", locationName: self.locNicknameTextField.text ?? ""), at: 0)
            } else {
                SelectedLocData.location.insert(Location(location: "\(self.locationTextField.text ?? "")", locationDetail: "\(self.locDetailTextField.text ?? "")", locationName: self.locationTextField.text ?? ""), at: 0)
            }
            
            SelectedLocData.saveAllData()
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // 완료버튼 활성화
    func completeButtonDisalbe() {
        if locationTextField.hasText && locDetailTextField.hasText {
            completeButton.isEnabled = true
        } else {
            completeButton.isEnabled = false
        }
    }
    
}
