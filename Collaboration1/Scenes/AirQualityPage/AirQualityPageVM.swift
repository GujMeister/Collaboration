//
//  AirQualityPageVM.swift
//  Collaboration1
//
//  Created by Ana on 5/17/24.
//

import Foundation
import SimpleNetworking

protocol AirQualityViewModelDelegate: AnyObject {
    func didFailWithError(error: Error)
    func didFetchCountries(countries: [String])
    func didFetchStates(states: [String])
    func didFetchCities(cities: [String])
    func didUpdateAirQuality(airQuality: AirQualityModel.PollutionData)
}


class AirQualityViewModel {
    weak var delegate: AirQualityViewModelDelegate?
    private let webService = WebService()
    
    private(set) var countries: [String]?
    private(set) var states: [String]?
    private(set) var cities: [String]?
    private(set) var selectedCountry: String?
    private(set) var selectedState: String?
    private(set) var selectedCity: String?
    
    func fetchCountries(apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/countries?key=\(apiKey)"
        
        WebService().fetchData(from: urlString, resultType: AirQualityModel.CountriesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.countries = response.data.map { $0.country }
                self?.delegate?.didFetchCountries(countries: self?.countries ?? [])
            case .failure(let error):
                self?.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchStates(country: String, apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/states?country=\(country)&key=\(apiKey)"
        
        webService.fetchData(from: urlString, resultType: AirQualityModel.StatesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.states = response.data.map { $0.state }
                self?.delegate?.didFetchStates(states: self?.states ?? [])
            case .failure(let error):
                self?.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchCities(state: String, country: String, apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/cities?state=\(state)&country=\(country)&key=\(apiKey)"
        
        webService.fetchData(from: urlString, resultType: AirQualityModel.CitiesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.cities = response.data.map { $0.city }
                self?.delegate?.didFetchCities(cities: self?.cities ?? [])
            case .failure(let error):
                self?.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchAirQuality(city: String, state: String, country: String, apiKey: String) {
        let urlString = "https://api.airvisual.com/v2/city?city=\(city)&state=\(state)&country=\(country)&key=\(apiKey)"
        
        webService.fetchData(from: urlString, resultType: AirQualityModel.AirQualityResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.didUpdateAirQuality(airQuality: response.data.current.pollution)
            case .failure(let error):
                self?.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    // Getters for the private properties
    func getCountries() -> [String]? {
        return countries
    }
    
    func getStates() -> [String]? {
        return states
    }
    
    func getCities() -> [String]? {
        return cities
    }
    
    func getSelectedCountry() -> String? {
        return selectedCountry
    }
    
    func getSelectedState() -> String? {
        return selectedState
    }
    
    func getSelectedCity() -> String? {
        return selectedCity
    }
    
    func setSelectedCountry(_ country: String?) {
        selectedCountry = country
    }
    
    func setSelectedState(_ state: String?) {
        selectedState = state
    }
    
    func setSelectedCity(_ city: String?) {
        selectedCity = city
    }
}
