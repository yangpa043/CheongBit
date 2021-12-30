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
    
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var locDetailTextField: UITextField!
    @IBOutlet weak var locNicknameTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let locationName = locationName {
            print("받았다!", locationName)
            LocationTextField.text = locationName
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
    
    // 화면터치로 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)

    }
    
    func appendCell() {
        if let userSelectedRow = userSelectedRow { // 주소 편집 할 때에
            
            if locNicknameTextField.hasText == true {
                SelectedLocData.shared.location[userSelectedRow].location = LocationTextField.text!
                SelectedLocData.shared.location[userSelectedRow].locationDetail = locDetailTextField.text!
                SelectedLocData.shared.location[userSelectedRow].name = locNicknameTextField.text!
            } else {
                SelectedLocData.shared.location[userSelectedRow].location = LocationTextField.text!
                SelectedLocData.shared.location[userSelectedRow].locationDetail = locDetailTextField.text!
                SelectedLocData.shared.location[userSelectedRow].name = LocationTextField.text!
            }
            
            
            NotificationCenter.default.post(name: NSNotification.Name("locationEditComplete"), object: nil)
            
            print(SelectedLocData.shared.location[userSelectedRow])
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        } else { // 주소 추가 할 때에
            if locNicknameTextField.hasText == true {
                SelectedLocData.shared.location.append(Location(location: "\(self.LocationTextField.text ?? "")", locationDetail: "\(self.locDetailTextField.text ?? "")", name: self.locNicknameTextField.text ?? ""))
            } else {
                SelectedLocData.shared.location.append(Location(location: "\(self.LocationTextField.text ?? "")", locationDetail: "\(self.locDetailTextField.text ?? "")", name: self.LocationTextField.text ?? ""))
            }
            
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // 완료버튼 활성화
    func completeButtonDisalbe() {
        if LocationTextField.hasText && locDetailTextField.hasText {
            completeButton.isEnabled = true
        } else {
            completeButton.isEnabled = false
        }
    }

}
