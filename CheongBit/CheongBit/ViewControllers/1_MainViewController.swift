//
//  ViewController.swift
//  CheongBit
//
//  Created by 짜미 on 2021/08/20.
//

import UIKit

class MainViewController: UIViewController {
    
    var switchONorOFF:Bool = false

    // MARK: - Outlets
    @IBOutlet weak var micSwitch: UIButton!
    @IBOutlet weak var micImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButtonUpdate()
    }

// MARK: - Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("tap")
    }
    
    @IBAction func switchChanged(_ sender: UIButton) {
        switchButtonUpdate()
    }
    
    // MARK: - Functions
    func switchButtonUpdate() {
        if switchONorOFF == true{
            micSwitch.setImage(UIImage(named: "switchOn"), for: .normal)
            micImage.image = UIImage(named: "micOn")
            switchONorOFF = false
        } else {
            micSwitch.setImage(UIImage(named: "switchOff"), for: .normal)
            micImage.image = UIImage(named: "micOff")
            switchONorOFF = true
        }
    }
}

