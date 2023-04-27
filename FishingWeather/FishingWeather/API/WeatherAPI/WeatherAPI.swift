//
//  WeatherAPI.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import Foundation
import Moya

enum WeatherAPI {
    case getCurrentWeatherData(lat: Double, lon: Double)
    case getFiveDaysWeatherData(lat: Double, lon: Double)
    case getForecastWeather(latLon: String, days: Int)
}

extension WeatherAPI: TargetType {
    
    var baseURL: URL {
        switch self {
            case .getCurrentWeatherData:
                return URL(string: "https://api.openweathermap.org/data/2.5/")!

            case .getFiveDaysWeatherData:
                return URL(string: "https://api.openweathermap.org/data/2.5/")!

            case .getForecastWeather:
                return URL(string: "https://api.weatherapi.com/v1/")!
        }
        
    }
        
    var path: String {
        switch self {
            case .getCurrentWeatherData:
                return "weather"
            case .getFiveDaysWeatherData:
                return "forecast"
            case .getForecastWeather:
                return "forecast.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getCurrentWeatherData, .getFiveDaysWeatherData:
                return .get
            case .getForecastWeather:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        guard let parameters else {
            return .requestPlain
        }
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        switch self {
            case .getCurrentWeatherData(let lat, let lon):
                params["lat"] = lat
                params["lon"] = lon
                params["appid"] = OPEN_WEATHER_API_KEY
                params["units"] = "metric"
            case .getFiveDaysWeatherData(let lat, let lon):
                params["lat"] = lat
                params["lon"] = lon
                params["appid"] = OPEN_WEATHER_API_KEY
                params["units"] = "metric"
            case .getForecastWeather(let latLon, let days):
                params["key"] = WEATHER_API
                params["q"] = latLon
                params["days"] = days
                params["aqi"] = "yes"
                params["alerts"] = "yes"
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getCurrentWeatherData, .getFiveDaysWeatherData:
                return URLEncoding.queryString
            case .getForecastWeather:
                return URLEncoding.queryString
        }
    }
    
}
