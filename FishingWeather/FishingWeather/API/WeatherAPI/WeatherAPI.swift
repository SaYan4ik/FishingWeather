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
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String {
        switch self {
            case .getCurrentWeatherData:
                return "weather"
            case .getFiveDaysWeatherData:
                return "forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getCurrentWeatherData, .getFiveDaysWeatherData:
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
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getCurrentWeatherData, .getFiveDaysWeatherData:
                return URLEncoding.queryString
        }
    }
    
}
