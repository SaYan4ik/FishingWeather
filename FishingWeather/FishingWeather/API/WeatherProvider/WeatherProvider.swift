//
//  WeatherProvider.swift
//  FishingWeather
//
//  Created by Александр Янчик on 4.04.23.
//

import Foundation
import Moya

final class WeatherProvider {
    private let provider = MoyaProvider<WeatherAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getForecastWeather(
        latLon: String,
        days: Int,
        comlition: @escaping ((ForecastModel) -> Void),
        failure: ((Error) -> Void)? = nil
    ) {
        provider.request(.getForecastWeather(latLon: latLon, days: days)) { result in
            switch result {
                case .success(let response):
                    guard let weather = try? JSONDecoder().decode(ForecastModel.self, from: response.data) else { return }
                    comlition(weather)
                case .failure(let error):
                    failure?(error)
            }
        }
        
    }
}
