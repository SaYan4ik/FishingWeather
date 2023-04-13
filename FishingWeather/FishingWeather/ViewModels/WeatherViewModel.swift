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

    @Published private(set) var weatherList: FiveDayWeatherModel?
    @Published private(set) var weatherToDay: WeatherModel?
    @Published private(set) var navTitle: String = ""
    
    let weatherProvider: WeatherProvider
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    private var currentLocation: CLLocation?
    
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        setCurrentLocationName()
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        self.weatherProvider.getFiveDaysWeather(lat: lat, lon: lon) { result in
            self.weatherList = result
        }
    }
    
    func fetchToDayWeather(lat: Double, lon: Double) {
        self.weatherProvider.getWeatherToDay(lat: lat, lon: lon) { weatherResult in
            self.weatherToDay = weatherResult
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
//            guard let streetNumber = placemark.subThoroughfare else { return }
//            guard let streetName = placemark.thoroughfare else { return }
            guard let city = placemark.locality else { return }
            guard let state = placemark.administrativeArea else { return }
//            guard let zipCode = placemark.postalCode else { return }
            
            DispatchQueue.main.async {
                self.navTitle = "\(city), \(state)"
            }
        }
    }
    
}

