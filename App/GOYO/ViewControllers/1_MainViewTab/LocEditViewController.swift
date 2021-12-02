//
//  LocEditViewController.swift
//  GOYO
//
//  Created by 짜미 on 2021/12/01.
//

import UIKit

class LocEditViewController: UIViewController {
    
    // MARK: - VC let/var
    
    var locationName: String?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var locDetailTextField: UITextField!
    @IBOutlet weak var locNicknameTextField: UITextField!
    
    
    // MARK: - VCLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let locationName = locationName {
            print("받았다!", locationName)
            LocationTextField.text = locationName
        }
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Functions

}
