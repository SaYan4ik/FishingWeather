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
    @Published private(set) var selectedIndex = IndexPath(item: 0, section: 0)
    
    let weatherProvider: WeatherProvider
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    private var currentLocation: CLLocation?
    
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        setCurrentLocationName()
    }
    
    func getForecastWeather(latLon: String, days: Int) {
        self.weatherProvider.getForecastWeather(latLon: latLon, days: days) { [weak self] forecastResult in
            guard let self else { return }
            self.forecastWeather = forecastResult
            
        }
    }
    
    private func setCurrentLocationName() {
        self.currentLocation = locationManager.location
        guard let currentLocation = self.currentLocation else {
            print("Unable to reverse-geocode location.")
            return
        }
        
        geocoder.reverseGeocodeLocation(currentLocation) { [weak self] (placemarks, error) in
            guard let self else { return }
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
    
    func setupNowForecast(weatherForecast: [HourForecastModel]) {
        weatherForecast.forEach { timeForecast in
            guard timeForecast.time != nil else { return }
            
            if let index = weatherForecast.firstIndex(where: {$0.time == "\(dataFormater())"}) {
                selectedIndex = IndexPath(item: index, section: 0)
            }
        }
    }
    
    func setupForecast(index: Int) {
        
    }
    
    private func dataFormater() -> String {
        let mytime = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:00"
        let myTime = format.string(from: mytime)
        return "\(myTime)"
    }
    
}

