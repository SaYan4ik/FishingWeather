//
//  WeatherModel.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import Foundation
import ObjectMapper

class WeatherModel: Mappable {
    var weather: [WeatherMain]?
    
    var temp: Double = 0.0
    var feelsLike: Double = 0.0
    var tempMin: Double = 0.0
    var tempMax: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
    var windSpeed: Double = 0.0
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        weather         <- map["weather"]
        temp            <- map["main.temp"]
        feelsLike       <- map["main.feels_like"]
        tempMin         <- map["main.temp_min"]
        tempMax         <- map["main.temp_max"]
        pressure        <- map["main.pressure"]
        humidity        <- map["main.humidity"]
        windSpeed       <- map["wind.speed"]
    }
    
}

class WeatherMain: Mappable {
    var main: String = ""
    var descripition: String = ""
    var imageWeather: String = ""
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        main <- map["main"]
        descripition <- map["description"]
        imageWeather <- map["icon"]
    }
}
