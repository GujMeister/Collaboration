//
//  PopulationPageVM.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//
//
import Foundation
import SimpleNetworking

protocol PopulationViewModelDelegate: AnyObject {
    func didUpdateCountries(_ countries: [String])
    func didFetchCountryInformation(_ information: String, for country: String)
    func didFailToFetchCountryInformation(withError error: Error)
}

final class PopulationViewModel {
    weak var delegate: PopulationViewModelDelegate?
    
    private var countries = [String]()
    private var filteredCountries = [String]()
    
    func fetchCountries() {
        let countriesAPIURL = "https://d6wn6bmjj722w.population.io/1.0/countries/?format=json"
        WebService().fetchData(from: countriesAPIURL, resultType: CountryResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.countries = response.countries
                self?.delegate?.didUpdateCountries(response.countries)
            case .failure(let error):
                self?.delegate?.didFailToFetchCountryInformation(withError: error)
            }
        }
    }
    
    func filterCountries(with searchText: String) {
        filteredCountries = countries.filter { $0.lowercased().starts(with: searchText.lowercased()) }
        delegate?.didUpdateCountries(filteredCountries)
    }
    
    func fetchCountryInformation(for country: String) {
        let countryInfoAPIURL = "https://d6wn6bmjj722w.population.io/1.0/population/\(country)/today-and-tomorrow/?format=json"
        WebService().fetchData(from: countryInfoAPIURL, resultType: PopulationData.self) { [weak self] result in
            switch result {
            case .success(let response):
                let populationInfo = response.totalPopulation.map { "Date: \($0.date), Population: \($0.population)" }.joined(separator: "\n")
                self?.delegate?.didFetchCountryInformation(populationInfo, for: country)
            case .failure(let error):
                self?.delegate?.didFailToFetchCountryInformation(withError: error)
            }
        }
    }
    
    func resetFilter() {
        delegate?.didUpdateCountries(countries)
    }
}
