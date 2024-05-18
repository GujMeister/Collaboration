//
//  AirQualityPageModel.swift
//  Collaboration1
//
//  Created by Ana on 5/17/24.
//

import Foundation

struct CountriesResponse: Decodable {
    let data: [Country]
    let status: String
}

struct Country: Decodable {
    let country: String
}


struct StatesResponse: Decodable {
    let data: [State]
    let status: String
}

struct State: Decodable {
    let state: String
}


struct CitiesResponse: Decodable {
    let data: [City]
    let status: String
}

struct City: Decodable {
    let city: String
}

struct AirQualityResponse: Decodable {
    let data: AirQualityData
    let status: String
}

struct AirQualityData: Decodable {
    let city: String
    let state: String
    let country: String
    let current: CurrentData
}

struct CurrentData: Decodable {
    let pollution: PollutionData
}

struct PollutionData: Decodable {
    let aqicn: Int
    let aqius: Int
    let maincn: String
    let mainus: String
}


