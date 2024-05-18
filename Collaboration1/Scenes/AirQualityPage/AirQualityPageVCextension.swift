//
//  AirQualityPageVCextension.swift
//  Collaboration1
//
//  Created by Ana on 5/18/24.
//

import UIKit

// MARK: - AirQualityViewModelDelegate

extension AirQualityPageVC: AirQualityViewModelDelegate {
    func didUpdateAirQuality(_ viewModel: AirQualityViewModel, airQuality: PollutionData) {
        DispatchQueue.main.async {
            self.airQualityLabel.text = "AQI US: \(airQuality.aqius)\nAQI CN: \(airQuality.aqicn)\nMain Pollutant US: \(airQuality.mainus)\nMain Pollutant CN: \(airQuality.maincn)"
            self.airQualityLabel.textColor = .white
            self.airQualityLabel.font = UIFont(name: "FiraGO-Regular", size: 17)
        }
    }
    
    func didFailWithError(_ viewModel: AirQualityViewModel, error: Error) {
        DispatchQueue.main.async {
            self.showAlert("There is no city in this state")
        }
    }
    
    func didFetchCountries(_ viewModel: AirQualityViewModel, countries: [String]) {
        DispatchQueue.main.async {
            viewModel.countries = countries
            self.countryPickerView.reloadAllComponents()
        }
    }
    
    func didFetchStates(_ viewModel: AirQualityViewModel, states: [String]) {
        DispatchQueue.main.async {
            viewModel.states = states
            self.statePickerView.reloadAllComponents()
        }
    }
    
    func didFetchCities(_ viewModel: AirQualityViewModel, cities: [String]) {
        DispatchQueue.main.async {
            viewModel.cities = cities
            self.cityPickerView.reloadAllComponents()
        }
    }
}

// MARK: - UIPickerViewDataSource

extension AirQualityPageVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return viewModel.countries?.count ?? 0
        case 2:
            return viewModel.states?.count ?? 0
        case 3:
            return viewModel.cities?.count ?? 0
        default:
            return 0
        }
    }
}

// MARK: - UIPickerViewDelegate

extension AirQualityPageVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return viewModel.countries?[row]
        case 2:
            return viewModel.states?[row]
        case 3:
            return viewModel.cities?[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            viewModel.selectedCountry = viewModel.countries?[row]
            countryTextField.text = viewModel.selectedCountry
            stateTextField.text = nil
            cityTextField.text = nil
            viewModel.states = nil
            viewModel.cities = nil
            statePickerView.reloadAllComponents()
            cityPickerView.reloadAllComponents()
        case 2:
            viewModel.selectedState = viewModel.states?[row]
            stateTextField.text = viewModel.selectedState
            cityTextField.text = nil
            viewModel.cities = nil
            cityPickerView.reloadAllComponents()
        case 3:
            viewModel.selectedCity = viewModel.cities?[row]
            cityTextField.text = viewModel.selectedCity
        default:
            break
        }
    }
}
