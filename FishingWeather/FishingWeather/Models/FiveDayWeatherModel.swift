//
//  FiveDayWeatherModel.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import Foundation
import ObjectMapper


class FiveDayWeatherModel: Mappable {
    var listWeatherModel: [ListWeatherModel] = []
    var city: CityWeatherModel?
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        listWeatherModel    <- map["list"]
        city                <- map["city"]
        
    }
    
}

class CityWeatherModel: Mappable {
    var name: String = ""
    var country: String = ""
    var timezone: Int = 0
    var sunrise: Int = 0
    var sunset: Int = 0
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
       name         <- map["name"]
       country      <- map["country"]
       timezone     <- map["timezone"]
       sunrise      <- map["sunrise"]
       sunset       <- map["sunset"]
    }
    
    
}

class ListWeatherModel: Mappable{
    var date: Int = 0
    
    var temp: Double = 0.0
    var tempMin: Double = 0.0
    var tempMax: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
    
    var weatherMain: [WeatherFiveDay] = []
    
//    var weatherTitle: String = ""
//    var weatherDescription: String = ""
//    var weatherIcon: String = ""
    
    var windSpeed: Double = 0.0
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        date                 <- map["dt"]
        temp                 <- map["main.temp"]
        tempMin              <- map["main.temp_min"]
        tempMax              <- map["main.temp_max"]
        pressure             <- map["main.pressure"]
        humidity             <- map["main.humidity"]
        weatherMain          <- map["weather"]
//        weatherTitle         <- map["weather.main"]
//        weatherDescription   <- map["weather.description"]
//        weatherIcon          <- map["weather.icon"]
        
        windSpeed            <- map["wind.speed"]
    }
}


class WeatherFiveDay: Mappable {
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
