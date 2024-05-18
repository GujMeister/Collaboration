//
//  SpeciePageVM.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import Foundation

final class SpeciePageVM {
    // MARK: - Properties
    private var countryCapitals: [String: (String, String)] = countryFlagsAndCapitals
    var filteredCountryCapitals: [String: (String, String)] = [:]
    
    var onFilteredCountriesUpdate: (() -> Void)?
    
    init() {
        filteredCountryCapitals = countryCapitals
    }
    
    // MARK: - Functions
    func filterCountries(with searchText: String) {
        if searchText.isEmpty {
            filteredCountryCapitals = countryCapitals
        } else {
            filteredCountryCapitals = countryCapitals.filter { $0.key.lowercased().starts(with: searchText.lowercased()) }
        }
        onFilteredCountriesUpdate?()
    }
    
    func getCountry(at index: Int) -> (String, (String, String)) {
        let countryNames = Array(filteredCountryCapitals.keys)
        let country = countryNames[index]
        let (flagEmoji, capital) = filteredCountryCapitals[country] ?? ("🏳️", "NA")
        return (country, (flagEmoji, capital))
    }
    
    func getCountriesCount() -> Int {
        return filteredCountryCapitals.count
    }
}
