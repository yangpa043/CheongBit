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
