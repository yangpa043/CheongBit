//
//  ReportDetailTableViewCell.swift
//  CheongBit
//
//  Created by 짜미 on 2021/09/15.
//

import UIKit

class ReportDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
