//
//  WeatherModel.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import Foundation

struct ForecastModel: Decodable {
//    "location" - key
    var location: LocationModel?
//    "current" - key
    var current: CurrentModel?
//    "forecast" - key
    var forecastday: ForecastForDaysModel?
    
    enum CodingKeys:String, CodingKey {
        case location = "location"
        case current = "current"
        case forecastday = "forecast"
    }
    
}

struct LocationModel: Decodable {
    var name: String?
    var region: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var localtimeEpoch: Int?
    var localTime: String?

    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case lat
        case lon
        case localtimeEpoch = "localtime_epoch"
        case localTime = "localtime"
    }
}

struct CurrentModel: Decodable {
    var lastUpdatedEpoch: Int?
    var lastUpdated: String?
    var tempC: Double?
    var condition: ConditionModel?
    var windMph: Double?
    var windDir: String?
    var preassureMph: Double?
    var humidity: Int?
    var cloud: Int?
    let feelsLikeC: Double?
    var airQuality: AirQualityModel?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
        case windMph = "wind_mph"
        case windDir = "wind_dir"
        case preassureMph = "pressure_mb"
        case humidity
        case cloud
        case feelsLikeC = "feelslike_c"
        case airQuality = "air_quality"
    }
    
}

struct ConditionModel: Decodable {
    var text: String?
    var icon: String?
    
    enum CodingKeys: CodingKey {
        case text
        case icon
    }
}

struct AirQualityModel: Decodable {
    var co: Double?
    var no2: Double?
    var o3: Double?
    var so2: Double?
    
    enum CodingKeys: CodingKey {
        case co
        case no2
        case o3
        case so2
    }
}

struct ForecastForDaysModel: Decodable {
    var forecastDay: [ForecastDayModel]?
    
    enum CodingKeys:String, CodingKey {
        case forecastDay = "forecastday"
    }
}

struct ForecastDayModel: Decodable {
    var date: String?
    var day: DayWeatherModel?
    var astro: AstroModel?
    var hourForecast: [HourForecastModel]?

    enum CodingKeys: String, CodingKey {
        case date
        case day
        case astro
        case hourForecast = "hour"
    }
}

struct DayWeatherModel: Decodable {
    var maxTempC: Double?
    var minTempC: Double?
    var avgTempC: Double?
    var maxWindMph: Double?
    
    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case minTempC = "mintemp_c"
        case avgTempC = "avgtemp_c"
        case maxWindMph = "maxwind_mph"
    }
}

struct AstroModel: Decodable {
    var sunRise: String?
    var sunSet: String?
    var moonRise: String?
    var moonSet: String?
    var moonPhase: String?
    var moonIllumination: String?
    
    enum CodingKeys: String, CodingKey {
        case sunRise = "sunrise"
        case sunSet = "sunset"
        case moonRise = "moonrise"
        case moonSet = "moonset"
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

struct HourForecastModel: Decodable {
    var timeEpoch: Int?
    var time: String?
    var tempC: Double?
    var conditionText: String?
    var conditionIcon: String?
    var condition: ConditionModel?
    var windMph: Double?
    var windDir: String?
    var preassureMb: Double?
    var hummidity: Int?
    var feelslikeC: Double?
    var chanceOfRain: Int?
    
    enum CodingKeys:String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case conditionText = "condition.text"
        case conditionIcon = "condition.icon"
        case condition
        case windMph = "wind_mph"
        case windDir = "wind_dir"
        case preassureMb = "pressure_mb"
        case hummidity = "humidity"
        case feelslikeC = "feelslike_c"
        case chanceOfRain = "chance_of_rain"
    }
    
}
