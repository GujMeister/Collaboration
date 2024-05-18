//
//  AirQualityPageVM.swift
//  Collaboration1
//
//  Created by Ana on 5/17/24.
//

import Foundation
import SimpleNetworking

protocol AirQualityViewModelDelegate: AnyObject {
    func didFailWithError(_ viewModel: AirQualityViewModel, error: Error)
    func didFetchCountries(_ viewModel: AirQualityViewModel, countries: [String])
    func didFetchStates(_ viewModel: AirQualityViewModel, states: [String])
    func didFetchCities(_ viewModel: AirQualityViewModel, cities: [String])
    func didUpdateAirQuality(_ viewModel: AirQualityViewModel, airQuality: PollutionData)
}

class AirQualityViewModel {
    weak var delegate: AirQualityViewModelDelegate?
    private let webService = WebService()
    
    var countries: [String]?
    var states: [String]?
    var cities: [String]?
    var selectedCountry: String?
    var selectedState: String?
    var selectedCity: String?
    
    func fetchCountries(apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/countries?key=\(apiKey)"
        
        webService.fetchData(from: urlString, resultType: CountriesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let countries = response.data.map { $0.country }
                self?.delegate?.didFetchCountries(self!, countries: countries)
            case .failure(let error):
                self?.delegate?.didFailWithError(self!, error: error)
            }
        }
    }
    
    func fetchStates(country: String, apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/states?country=\(country)&key=\(apiKey)"
        
        webService.fetchData(from: urlString, resultType: StatesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let states = response.data.map { $0.state }
                self?.delegate?.didFetchStates(self!, states: states)
            case .failure(let error):
                self?.delegate?.didFailWithError(self!, error: error)
            }
        }
    }
    
    func fetchCities(state: String, country: String, apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/cities?state=\(state)&country=\(country)&key=\(apiKey)"
        
        webService.fetchData(from: urlString, resultType: CitiesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let cities = response.data.map { $0.city }
                self?.delegate?.didFetchCities(self!, cities: cities)
            case .failure(let error):
                self?.delegate?.didFailWithError(self!, error: error)
            }
        }
    }
    
    func fetchAirQuality(city: String, state: String, country: String, apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/city?city=\(city)&state=\(state)&country=\(country)&key=\(apiKey)"
        
        webService.fetchData(from: urlString, resultType: AirQualityResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.didUpdateAirQuality(self!, airQuality: response.data.current.pollution)
            case .failure(let error):
                self?.delegate?.didFailWithError(self!, error: error)
            }
        }
    }
}
