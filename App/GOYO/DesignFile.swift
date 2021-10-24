//
//  design.swift
//  GOYO
//
//  Created by 짜미 on 2021/09/07.
//

import Foundation
import UIKit

// 흰색 텍스트
class whiteText: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}


// MARK: - 메인페이지

//신고 버튼
class reportButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        layer.cornerRadius = 25;
        backgroundColor = #colorLiteral(red: 0, green: 0.4877254963, blue: 1, alpha: 1)
        tintColor = UIColor.white
    }
}

// 메인페이지 주소선택 버튼 색 버그 수정 코드
class mainViewNavButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        tintColor = #colorLiteral(red: 0, green: 0.4877254963, blue: 1, alpha: 1)
    }
}
