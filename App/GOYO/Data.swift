//
//  DummyData.swift
//  GOYO
//
//  Created by 권은세 on 2021/09/10.
//

import Foundation
import UIKit


public struct Location {
    var location: String
    var locationDetail: String
    var name: String
}

class SelectedLocData {
    static let shared = SelectedLocData()
    
    var location: [Location] = [
        Location(location: "현재 나의 위치를 조회하여 신고합니다.", locationDetail: "", name: "현재 나의 위치")
    ]
}

