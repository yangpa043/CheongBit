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
    static var location: [Location] = [
        Location(location: "서울 종로구 대학로 116", locationDetail: "공공일호 4층", name: "거캠")
    ]
}
