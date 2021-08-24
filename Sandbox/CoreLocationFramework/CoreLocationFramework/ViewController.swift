//
//  ViewController.swift
//  CoreLocationFramework
//
//  Created by 짜미 on 2021/08/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager:CLLocationManager!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func getLocationInfo() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            print("에잇..이런..gps...")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]) {
        guard let location = manager.location else {
            return
        }
        let cor = location.coordinate
        printAddressBasedOnGPS(lati: cor.latitude, longi: cor.longitude)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        if sender.isOn {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
}

extension ViewController{
    func printAddressBasedOnGPS(lati:CLLocationDegrees, longi:CLLocationDegrees) {
        let findLocation = CLLocation(latitude: lati, longitude: longi)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            
            if let address: [CLPlacemark] = placemarks {
                if let name: String = address.last?.name{
                    print(name, lati, address)
                    self.addressLabel.text = "\(name) : GPS\(lati)"
                }
            }
            
        })
    }
}
