//
//  WeatherForecastModel.swift
//  Collaboration1
//
//  Created by Nodiko Gachava on 19.05.24.
//

import Foundation
final class WeatherPageModel {
    struct WeatherForecast: Codable {
        let list: [Forecast]
        let city: City
    }
    
    struct Forecast: Codable {
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
    }
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let timezone: Int
        let sunrise: Int
        let sunset: Int
    }
    
    struct Coord: Codable {
        let lat: Double
        let lon: Double
    }
}
