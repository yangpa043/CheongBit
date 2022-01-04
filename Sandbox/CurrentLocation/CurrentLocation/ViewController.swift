//
//  ViewController.swift
//  CurrentLocation
//
//  Created by 짜미 on 2021/12/28.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManger = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치서비스 On")
        } else {
            print("위치서비스 Off")
        }
        
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            locationManger.startUpdatingLocation()
        } else {
            print("위치서비스가 꺼져있어요")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            latitudeLabel.text = "위도: \(location.coordinate.latitude)"
            longitudeLabel.text = "경도: \(location.coordinate.longitude)"
            locationManger.stopUpdatingLocation()
        }
    }
    
    // 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    let findLocation = CLLocation(latitude: 37.576029, longitude: 126.976920)
    let geocoder = CLGeocoder()
    let locale = Locale(identifier: "Ko-kr")
}

