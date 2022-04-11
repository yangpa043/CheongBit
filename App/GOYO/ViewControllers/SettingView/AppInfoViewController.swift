//
//  AppInfoViewController.swift
//  GOYO
//
//  Created by 짜미 on 2022/03/28.
//

import UIKit

class AppInfoViewController: UIViewController {

    // MARK: - Variables
    
    var version: String? {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return version
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appIcon.layer.cornerRadius = 20
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        appIcon.layer.borderWidth = 0.7
        appIcon.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        versionLabel.text = version
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Functions
    


}
