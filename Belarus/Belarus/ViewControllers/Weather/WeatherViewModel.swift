//
//  WeatherViewModel.swift
//  Belarus
//
//  Created by user on 19.10.22.
//

import Foundation
import UIKit

struct WeatherData {
    var latitude: Double
    var longitude: Double
}

typealias VoidHandler = () -> Void

class WeatherViewModel {
    
    let data: WeatherData
    
    init(data: WeatherData){
        self.data = data
    }

    var bindWeather: Bindable<Hourly> = Bindable()
    let activityIndicatorVisability: Bindable<Bool> = Bindable()
    
    func loadWeather() async {
        activityIndicatorVisability.update(with: false)
        do {
            let weather: Weather = try await NetworkActor.request(router: WeatherRouter.getWeather(latitude: data.latitude, longitude: data.longitude))
            if let hourly = weather.hourly {
                bindWeather.update(with: hourly)
            }
            activityIndicatorVisability.update(with: true)
        } catch {
            activityIndicatorVisability.update(with: true)
            print(error.localizedDescription)
        }
    }
    
}
