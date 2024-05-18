//
//  WeatherPageVM.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import Foundation
import SimpleNetworking

final class WeatherPageVM {
    var fetchedData: WeatherPageModel.WeatherForecast?
    var onDataFetched: ((WeatherPageModel.WeatherForecast?) -> Void)?
    
    func fetchWeather(with passedCity: String) {
        WebService().fetchData(from: "https://api.openweathermap.org/data/2.5/forecast?q=\(passedCity)&appid=159e264bbb707514e8ea1734c14e4169",
                               resultType: WeatherPageModel.WeatherForecast.self) { result in
            switch result {
            case .success(let receivedForecast):
                self.onDataFetched?(receivedForecast)
                print(receivedForecast)
            case .failure(let error):
                print("Error fetching city ID: \(error)")
            }
        }
    }
}

