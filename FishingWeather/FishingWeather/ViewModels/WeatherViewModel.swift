//
//  WeatherViewModel.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import UIKit
import CoreLocation
import Combine

class WeatherViewModel {
    @Published private(set) var navTitle: String = ""
    @Published private(set) var forecastWeather: ForecastModel?
    
    let weatherProvider: WeatherProvider
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    private var currentLocation: CLLocation?
    
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        setCurrentLocationName()
    }
    
    func getForecastWeather(latLon: String, days: Int) {
        self.weatherProvider.getForecastWeather(latLon: latLon, days: days) { forecastResult in
            self.forecastWeather = forecastResult
        }
    }
    
    func setCurrentLocationName() {
        self.currentLocation = locationManager.location
        guard let currentLocation = self.currentLocation else {
            print("Unable to reverse-geocode location.")
            return
        }
        
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                print(error)
            }
            
            guard let placemark = placemarks?.first else { return }
            guard let city = placemark.locality else { return }
            guard let state = placemark.administrativeArea else { return }
            
            DispatchQueue.main.async {
                self.navTitle = "\(city), \(state)"
            }
        }
    }
    
    
}

