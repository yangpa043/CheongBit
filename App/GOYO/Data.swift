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
    var locationName: String
}

class SelectedLocData {
    static var location: [Location] = []
    
    // 유저데이터 불러오기
    static func loadAllData() {
        print("[loadUserData]")
        let userDefaults = UserDefaults.standard
        guard let locationData = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {return}
        
        SelectedLocData.location = locationData.map {
            let location = $0["location"] as? String ?? ""
            let locationDetail = $0["locationDetail"] as? String ?? ""
            let locationName = $0["locationName"] as? String ?? ""
            
            return Location(location: location, locationDetail: locationDetail, locationName: locationName)
        }
    }
    
    // 유저데이터 저장하기
    static func saveAllData() {
        print("[saveUserData]")
        let locationData = SelectedLocData.location.map {
            [
                "location": $0.location,
                "locationDetail": $0.locationDetail,
                "locationName": $0.locationName
            ]
        }
        
        let userDefault = UserDefaults.standard
        userDefault.set(locationData, forKey: "items")
        userDefault.synchronize()
    }
}
