//
//  WeatherModel.swift
//  Belarus
//
//  Created by user on 21.10.22.
//

import Foundation
import UIKit

struct Weather: Decodable {
    let latitude: Double
    let longitude: Double
    let generationtimeMs: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    let hourlyUnits: HourlyUnits?
    let hourly: Hourly?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, elevation, timezone,hourly
        case generationtimeMs = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezoneAbbreviation = "timezone_abbreviation"
        case hourlyUnits = "hourly_units"
    }
}

struct HourlyUnits: Decodable {
    let time: String
    let temperature2m: String
    let apparentTemperature: String
    let rain: String
    let snowfall: String
    let cloudcover: String
    let windspeed10m: String

    enum CodingKeys: String, CodingKey {
        case time, rain, snowfall, cloudcover
        case temperature2m = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case windspeed10m = "windspeed_10m"
    }
}

struct Hourly: Decodable {
    let time: [String]
    let temperature2m: [Float]
    let apparentTemperature: [Float]
    let rain: [Float]
    let snowfall: [Float]
    let cloudcover: [Int]
    let windspeed10m: [Float]

    enum CodingKeys: String, CodingKey {
        case time, rain, snowfall, cloudcover
        case temperature2m = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case windspeed10m = "windspeed_10m"
    }
}
