//
//  AirQualityPageVCextension.swift
//  Collaboration1
//
//  Created by Ana on 5/18/24.
//

import UIKit

// MARK: - AirQualityViewModelDelegate

extension AirQualityPageVC: AirQualityViewModelDelegate {
    func didUpdateAirQuality(airQuality: AirQualityModel.PollutionData) {
        DispatchQueue.main.async {
            self.airQualityLabel.text = "AQI US: \(airQuality.aqius)\nAQI CN: \(airQuality.aqicn)\nMain Pollutant US: \(airQuality.mainus)\nMain Pollutant CN: \(airQuality.maincn)"
            self.airQualityLabel.textColor = .white
            self.airQualityLabel.font = UIFont(name: "FiraGO-Regular", size: 16)
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.showAlert("🥹 There is no city in this state 🥹")
        }
    }
    
    func didFetchCountries(countries: [String]) {
        DispatchQueue.main.async {
            self.countryPickerView.reloadAllComponents()
        }
    }
    
    func didFetchStates(states: [String]) {
        DispatchQueue.main.async {
            self.statePickerView.reloadAllComponents()
        }
    }
    
    func didFetchCities(cities: [String]) {
        DispatchQueue.main.async {
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
            return viewModel.getCountries()?.count ?? 0
        case 2:
            return viewModel.getStates()?.count ?? 0
        case 3:
            return viewModel.getCities()?.count ?? 0
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
            return viewModel.getCountries()?[row]
        case 2:
            return viewModel.getStates()?[row]
        case 3:
            return viewModel.getCities()?[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            viewModel.setSelectedCountry(viewModel.getCountries()?[row])
            countryTextField.text = viewModel.getSelectedCountry()
            stateTextField.text = nil
            cityTextField.text = nil
            viewModel.setSelectedState(nil)
            viewModel.setSelectedCity(nil)
            statePickerView.reloadAllComponents()
            cityPickerView.reloadAllComponents()
        case 2:
            viewModel.setSelectedState(viewModel.getStates()?[row])
            stateTextField.text = viewModel.getSelectedState()
            cityTextField.text = nil
            viewModel.setSelectedCity(nil)
            cityPickerView.reloadAllComponents()
        case 3:
            viewModel.setSelectedCity(viewModel.getCities()?[row])
            cityTextField.text = viewModel.getSelectedCity()
        default:
            break
        }
    }
}
