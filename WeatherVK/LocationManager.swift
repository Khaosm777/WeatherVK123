//
//  LocationManager.swift
//  WeatherVK
//
//  Created by Admin on 23.03.2024.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var cityUpdateHandler: ((String) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            guard let placemark = placemarks?.first else { return }
            if let city = placemark.locality {
                print("Город: \(city)")
                self.cityUpdateHandler?(city)
            }
        }
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка при получении геолокации: \(error.localizedDescription)")
    }
}
