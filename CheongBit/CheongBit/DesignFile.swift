//
//  design.swift
//  CheongBit
//
//  Created by 짜미 on 2021/09/07.
//

import Foundation
import UIKit

class reportButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        layer.cornerRadius = 25;
        backgroundColor = UIColor.black
        tintColor = UIColor.white
    }
}

class mainViewNavButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        tintColor = UIColor(red: 1/255, green: 122/255, blue: 255/255, alpha: 1)
    }
}
