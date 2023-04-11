//
//  WeatherProvider.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class WeatherProvider {
    private let provider = MoyaProvider<WeatherAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getFiveDaysWeather(lat: Double, lon: Double, comlition: @escaping ((FiveDayWeatherModel) -> Void), failure: ((Error) -> Void)? = nil) {
        provider.request(.getFiveDaysWeatherData(lat: lat, lon: lon)) { result in
            switch result {
                case .success(let response):
                    guard let weather = try? response.mapObject(FiveDayWeatherModel.self) else { return }
                    comlition(weather)
                case .failure(let error):
                    failure?(error)
            }
        }
    }
}
