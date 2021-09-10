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
        User(userImage: "micOff", userName: "이롱", userId: "irong49"),
        User(userImage: "micOn", userName: "우유", userId: "wooyou11"),
        User(userImage: "switchOn", userName: "양파", userId: "yangpa043"),
        User(userImage: "switchOff", userName: "히재", userId: "kimseeit")
    
    ]
}
