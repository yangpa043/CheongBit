//
//  ViewController.swift
//  ModalPresent
//
//  Created by 짜미 on 2021/11/24.
//

import UIKit
//import 

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func modalButtonTapped(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "modalViewController")
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName!, animated: true, completion: nil)
    }
    
}
