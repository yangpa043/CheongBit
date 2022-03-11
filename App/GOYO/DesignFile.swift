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
        textColor = #colorLiteral(red: 0.1098039216, green: 0.1019607843, blue: 0.2235294118, alpha: 1)
    }
}


// MARK: - 메인페이지

//신고 버튼
class reportButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1019607843, blue: 0.2235294118, alpha: 1)
        tintColor = #colorLiteral(red: 0.9997131228, green: 0.9688497186, blue: 0.8411275744, alpha: 1)
        layer.cornerRadius = 20.0
        
        
    }
}

// 메인페이지 주소선택 버튼 색 버그 수정 코드
class mainViewNavButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        tintColor = #colorLiteral(red: 0.1098039216, green: 0.1019607843, blue: 0.2235294118, alpha: 1)
    }
}

//기본 배경설정
class ViewDesign: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        backgroundColor = #colorLiteral(red: 0.9997131228, green: 0.9688497186, blue: 0.8411275744, alpha: 1)
//        tintColor = #colorLiteral(red: 0.1098039216, green: 0.1019607843, blue: 0.2235294118, alpha: 1)
    }
}
