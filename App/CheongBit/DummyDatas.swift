//
//  DummyData.swift
//  CheongBit
//
//  Created by 권은세 on 2021/09/10.
//

import Foundation

struct User {
    var userImage: String
    var userName: String
    var userId: String
    
}
class UserDummyData {
    static let shared = UserDummyData()
    
    var user: [User] = [
        User(userImage: "switchOn", userName: "이롱", userId: "irong49"),
        User(userImage: "switchOff", userName: "우유", userId: "wooyou11"),
        User(userImage: "switchOn", userName: "양파", userId: "yangpa043"),
        User(userImage: "switchOff", userName: "히재", userId: "kimseeit"),
        User(userImage: "switchOn", userName: "딩동", userId: "rlaehdbs05")
    
    ]
}


struct Location {
    var location: String
    var name: String
}
class LocationDummyData {
    static let shared = LocationDummyData()
    
    var location: [Location] = [
        Location(location: "서울특별시 종로구 이화동 대학로 116", name: "학교"),
        Location(location: "서울특별시 성북구 성북로5길 45-4", name: "기숙사"),
        Location(location: "경기도 양평군 양서면 양수로 177-6", name: "집"),
        Location(location: "충청북도 흥덕구 가경동 서현서로 21-3", name: "우유 집"),
        Location(location: "경기도 용인시 수지구 신봉2로 34-4", name: "양파 전집"),
        Location(location: "대구광역시 달서구 조안남로16길 19", name: "두부 집")
    ]
}

var otherViewLocationData : String = "주소를 선택해주세요  ⌵"
