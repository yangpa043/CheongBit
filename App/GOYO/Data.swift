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
        Location(location: "경기 양평군 양수로 177-6", locationDetail: "702호", name: "샘플 주소")
    ]
}

