//
//  LocEditViewController.swift
//  GOYO
//
//  Created by 짜미 on 2021/12/01.
//

import UIKit

class LocEditViewController: UIViewController {
    
    // MARK: - Variables
    
    var locationName: String?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var locDetailTextField: UITextField!
    @IBOutlet weak var locNicknameTextField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        completeButtonDisalbe()
        
        if let locationName = locationName {
            print("받았다!", locationName)
            LocationTextField.text = locationName
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func editCompleteButtonTapped(_ sender: Any) {
        SelectedLocData.shared.location.append(Location(location: "\(self.LocationTextField.text ?? "") \(self.locDetailTextField.text ?? "")", name: self.locNicknameTextField.text ?? ""))
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func keyboardDoneButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func checkEditing(_ sender: Any) {
        completeButtonDisalbe()
    }
    
    // MARK: - Functions
    
    // 화면터치로 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)

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
