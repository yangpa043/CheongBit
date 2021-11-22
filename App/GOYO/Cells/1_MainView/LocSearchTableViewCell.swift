//
//  LocSearchTableViewCell.swift
//  GOYO
//
//  Created by 짜미 on 2021/11/19.
//

import Foundation
import UIKit

public struct SearchLocation {
    let locationName: String
    
    var roadLoc: String
    var jibunLoc: String
    
    var depthOneLoc: String
    var deptTwoLoc: String
    var deptThreeLoc: String
}

protocol ResultCellDelegate {
    func didSelectOK(didSelectItem: SearchLocation?)
}

class LocSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var labelRoadLoc: UILabel!
    @IBOutlet weak var labelJibunLoc: UILabel!
    
    var item: SearchLocation? {
        didSet {
            self.labelRoadLoc.text  = item?.roadLoc
            self.labelJibunLoc.text = item?.jibunLoc
        }
    }
    
    var delegate: ResultCellDelegate?

    @IBAction func selectButtonTapped(_ sender: Any) {
        self.delegate?.didSelectOK(didSelectItem: self.item)
    }
    
}
