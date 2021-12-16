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
    var name: String
}

class SelectedLocData {
    static let shared = SelectedLocData()
    
    var location: [Location] = [
        Location(location: "현재 나의 위치를 조회하여 신고합니다.", name: "현재 나의 위치"),
        Location(location: "서울특별시 종로구 이화동 대학로 116", name: "학교"),
        Location(location: "서울특별시 성북구 성북로5길 45-4", name: "기숙사"),
        Location(location: "경기도 양평군 양서면 양수로 177-6", name: "집"),
        Location(location: "충청북도 흥덕구 가경동 서현서로 21-3", name: "우유 집"),
        Location(location: "경기도 용인시 수지구 신봉2로 34-4", name: "양파 전집"),
        Location(location: "대구광역시 달서구 조안남로16길 19", name: "두부 집"),
        Location(location: "서울 마포구 신공덕동159", name: "호랑이굴")
    ]
}

