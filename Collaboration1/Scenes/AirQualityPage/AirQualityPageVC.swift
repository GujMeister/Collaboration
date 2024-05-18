//
//  AirQualityPageVC.swift
//  Collaboration1
//
//  Created by Ana on 5/17/24.
//

import UIKit

class AirQualityPageVC: UIViewController {
    
    private let viewModel = AirQualityViewModel()
    var countries: [String]?
    var states: [String]?
    var cities: [String]?
    var selectedCountry: String?
    var selectedState: String?
    var selectedCity: String?
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Image")
        return image
    }()
    
    lazy var countryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Country"
        textField.backgroundColor = UIColor(hex: "#262A34")
        textField.textColor = .white
        textField.borderStyle = .roundedRect
//        textField.borderStyle = .none
//        textField.layer.cornerRadius = 15
//        textField.layer.masksToBounds = true
        textField.inputView = countryPickerView
        textField.inputAccessoryView = pickerViewToolbar

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select Country", attributes: placeholderAttributes)
        return textField
    }()

    lazy var stateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select State"
        textField.backgroundColor = UIColor(hex: "#262A34")
        textField.textColor = .white
        textField.borderStyle = .roundedRect

//        textField.borderStyle = .none
//        textField.layer.cornerRadius = 15
//        textField.layer.masksToBounds = true
        textField.inputView = statePickerView
        textField.inputAccessoryView = pickerViewToolbar

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select State", attributes: placeholderAttributes)
        return textField
    }()

    lazy var cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select City"
        textField.backgroundColor = UIColor(hex: "#262A34")
        textField.textColor = .white
        textField.borderStyle = .roundedRect

//        textField.borderStyle = .none
//        textField.layer.cornerRadius = 15
//        textField.layer.masksToBounds = true
        textField.inputView = cityPickerView
        textField.inputAccessoryView = pickerViewToolbar

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select City", attributes: placeholderAttributes)
        return textField
    }()

    lazy var fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch Air Quality", for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraGO-Bold", size: 14)
        button.backgroundColor = UIColor(hex: "#262A34")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var airQualityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var pickerViewToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    lazy var countryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = 1
        return pickerView
    }()
    
    lazy var statePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = 2
        return pickerView
    }()
    
    lazy var cityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = 3
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#3C4251")
        setupViews()
        
        viewModel.delegate = self
        fetchCountries()
    }
    
    private func setupViews() {
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(countryTextField)
        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countryTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(stateTextField)
        stateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stateTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 20),
            stateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateTextField.widthAnchor.constraint(equalTo: countryTextField.widthAnchor),
            stateTextField.heightAnchor.constraint(equalTo: countryTextField.heightAnchor)
        ])
        
        view.addSubview(cityTextField)
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: stateTextField.bottomAnchor, constant: 20),
            cityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityTextField.widthAnchor.constraint(equalTo: countryTextField.widthAnchor),
            cityTextField.heightAnchor.constraint(equalTo: countryTextField.heightAnchor)
        ])
        
        view.addSubview(fetchButton)
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fetchButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 50),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            fetchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            fetchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(airQualityLabel)
        airQualityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            airQualityLabel.topAnchor.constraint(equalTo: fetchButton.bottomAnchor, constant: 30),
            airQualityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            airQualityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func fetchCountries() {
        let apiKey = "9491b1c0-d840-4ca0-a8a1-7ed13b629f4c"
        viewModel.fetchCountries(apiKey: apiKey)
    }
    
    @objc private func fetchButtonTapped() {
        guard let country = selectedCountry,
              let state = selectedState,
              let city = selectedCity, !city.isEmpty else {
            showAlert("Please fill in all fields.")
            return
        }
        
        let apiKey = "9491b1c0-d840-4ca0-a8a1-7ed13b629f4c"
        viewModel.fetchAirQuality(city: city, state: state, country: country, apiKey: apiKey)
    }
    
    @objc private func doneButtonTapped() {
        if countryTextField.isFirstResponder {
            countryTextField.resignFirstResponder()
            if let country = selectedCountry {
                let apiKey = "9491b1c0-d840-4ca0-a8a1-7ed13b629f4c"
                viewModel.fetchStates(country: country, apiKey: apiKey)
            }
        } else if stateTextField.isFirstResponder {
            stateTextField.resignFirstResponder()
            if let state = selectedState, let country = selectedCountry {
                let apiKey = "9491b1c0-d840-4ca0-a8a1-7ed13b629f4c"
                viewModel.fetchCities(state: state, country: country, apiKey: apiKey)
            }
        } else if cityTextField.isFirstResponder {
            cityTextField.resignFirstResponder()
        }
    }
    
    public func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

//extension AirQualityPageVC: AirQualityViewModelDelegate {
//    func didUpdateAirQuality(_ viewModel: AirQualityViewModel, airQuality: PollutionData) {
//        DispatchQueue.main.async {
//            self.airQualityLabel.text = "AQI US: \(airQuality.aqius)\nAQI CN: \(airQuality.aqicn)\nMain Pollutant US: \(airQuality.mainus)\nMain Pollutant CN: \(airQuality.maincn)"
//        }
//    }
//    
//    func didFailWithError(_ viewModel: AirQualityViewModel, error: Error) {
//        DispatchQueue.main.async {
//            self.showAlert("Failed to fetch air quality data: \(error.localizedDescription)")
//        }
//    }
//    
//    func didFetchCountries(_ viewModel: AirQualityViewModel, countries: [String]) {
//        DispatchQueue.main.async {
//            self.countries = countries
//            self.countryPickerView.reloadAllComponents()
//        }
//    }
//    
//    func didFetchStates(_ viewModel: AirQualityViewModel, states: [String]) {
//        DispatchQueue.main.async {
//            self.states = states
//            self.statePickerView.reloadAllComponents()
//        }
//    }
//    
//    func didFetchCities(_ viewModel: AirQualityViewModel, cities: [String]) {
//        DispatchQueue.main.async {
//            self.cities = cities
//            self.cityPickerView.reloadAllComponents()
//        }
//    }
//}
//
//extension AirQualityPageVC: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch pickerView.tag {
//        case 1:
//            return countries?.count ?? 0
//        case 2:
//            return states?.count ?? 0
//        case 3:
//            return cities?.count ?? 0
//        default:
//            return 0
//        }
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch pickerView.tag {
//        case 1:
//            return countries?[row]
//        case 2:
//            return states?[row]
//        case 3:
//            return cities?[row]
//        default:
//            return nil
//        }
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch pickerView.tag {
//        case 1:
//            selectedCountry = countries?[row]
//            countryTextField.text = selectedCountry
//            stateTextField.text = nil
//            cityTextField.text = nil
//            states = nil
//            cities = nil
//            statePickerView.reloadAllComponents()
//            cityPickerView.reloadAllComponents()
//        case 2:
//            selectedState = states?[row]
//            stateTextField.text = selectedState
//            cityTextField.text = nil
//            cities = nil
//            cityPickerView.reloadAllComponents()
//        case 3:
//            selectedCity = cities?[row]
//            cityTextField.text = selectedCity
//        default:
//            break
//        }
//    }
//}
