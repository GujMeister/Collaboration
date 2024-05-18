//
//  WeatherPageVC.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import UIKit

class WeatherPageVC: UIViewController {
    // MARK: - Variables
    
    let viewModel = WeatherPageVM()
    
    // MARK: - UI Components
    private let background: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Weather")
        image.tintColor = .white
        return image
    }()
    
    private let countryName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Country Name"
        textField.layer.cornerRadius = 2
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "weatherCol")?.cgColor
        textField.textColor = .white
        textField.font = UIFont(name: "FiraGO", size: 12)
        return textField
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "country Name"
        return label
    }()
   
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "temp"
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "weather"
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "max"
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "min"
        return label
    }()
    
    private let timezoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "timezone"
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor(named: "weatherCol")
        button.layer.cornerRadius = 2
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.onDataFetched = { [weak self] weather in
            guard let self = self, let weather = weather else { return }
            DispatchQueue.main.async {
                self.updateUI(with: weather)
            }
        }
        
    }
    
    
    // MARK: - UI Setup
    func setupUI() {
        self.view.backgroundColor = .red
        let views = [background, countryName, countryLabel, tempLabel, weatherLabel, maxTempLabel, minTempLabel, timezoneLabel, searchButton]
        views.forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            countryName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            countryName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            countryName.widthAnchor.constraint(equalToConstant: 200),
            countryName.heightAnchor.constraint(equalToConstant: 40),
            
            background.topAnchor.constraint(equalTo: self.view.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            countryLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250),
            countryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290),
            tempLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            weatherLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 330),
            weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             
            maxTempLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 370),
            maxTempLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            minTempLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 410),
            minTempLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            timezoneLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450),
            timezoneLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            searchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 500),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    @objc func searchButtonTapped() {
        guard let city = countryName.text, !city.isEmpty else {
            print("Please enter a city name.")
            return
        }
        viewModel.fetchWeather(with: city)
    }
    func updateUI(with weather: WeatherForecast) {
        if let temp = weather.list.first?.main.temp {
            tempLabel.text = "\(temp-273.15)°C"
        }
        if let minTemp = weather.list.first?.main.temp_min {
            minTempLabel.text = "\(minTemp-273.13)"
        }
    }
}

