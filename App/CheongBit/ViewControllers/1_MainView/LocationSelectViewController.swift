//
//  LocationSelectViewController.swift
//  CheongBit
//
//  Created by 권은세 on 2021/09/07.
//

import UIKit

class LocationSelectViewController: UIViewController {
    
// MARK: - Outlets
    @IBOutlet weak var locationEnterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDynamicFont()
    }
    
    //뒤로가기 버튼
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    // MARK: - Functions
    func applyDynamicFont() {
        locationEnterLabel.dynamicFont(fontSize: 35, weight: .regular)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
