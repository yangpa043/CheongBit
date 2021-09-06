//
//  ViewController.swift
//  CheongBit
//
//  Created by 짜미 on 2021/08/20.
//

import UIKit

class ViewController: UIViewController {
    
    var switchValue:Bool = false

    @IBOutlet weak var micSwitch: UIButton!
    
    @IBOutlet weak var micImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchButtonUpdate()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        print("tap")
    }
    
    @IBAction func switchChanged(_ sender: UIButton) {
        switchButtonUpdate()
    }
    
    func switchButtonUpdate() {
        if switchValue == true{
//            micSwitch.setTitle("on", for: .normal)
            micSwitch.setImage(UIImage(named: "switchOn"), for: .normal)
            micImage.image = UIImage(named: "micOn")
            switchValue = false
        } else {
//            micSwitch.setTitle("off", for: .normal)
            micSwitch.setImage(UIImage(named: "switchOff"), for: .normal)
            micImage.image = UIImage(named: "micOff")
            switchValue = true
        }
    }
}

