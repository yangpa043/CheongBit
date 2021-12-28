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
        Location(location: "경기 양평군 양수로 177-6", locationDetail: "702호", name: "샘플 주소 1"),
        Location(location: "울산 울주군 청량읍 삼정로 92", locationDetail: "207-905", name: "샘플 주소 2")
    ]
}
