//
//  WeatherRouter.swift
//  Belarus
//
//  Created by user on 21.10.22.
//

import Foundation

enum WeatherRouter: NetworkRouterProtocol {
    
    case getWeather(latitude: Double, longitude: Double)
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.open-meteo.com"
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/v1/forecast"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getWeather(let latitude, let longitude):
            return [
                URLQueryItem(name: "latitude", value: "\(latitude)"),
                URLQueryItem(name: "longitude", value: "\(longitude)"),
                URLQueryItem(name: "hourly", value: "temperature_2m,apparent_temperature,rain,snowfall,cloudcover,windspeed_10m")
//                URLQueryItem(name: "timezone", value: timeZone),
//                URLQueryItem(name: "daily", value: daily.joined(separator: ","))
            ]
        }
    }
}
