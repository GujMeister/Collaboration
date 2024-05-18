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
        
    private let countryName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Country Name"
        textField.layer.cornerRadius = 2
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hex: "262A34").cgColor
        textField.textColor = .white
        textField.font = UIFont(name: "FiraGO", size: 12)
        return textField
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
   
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 60, weight: .semibold)
        return label
    }()
    
    private var weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor(hex: "262A34")
        button.layer.cornerRadius = 2
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private  let weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "thermometer.sun")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        image.tintColor = .white
        return image
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
        self.view.backgroundColor = UIColor(hex: "#3C4251")
        let views = [ countryName, countryLabel, tempLabel, weatherLabel, maxTempLabel, minTempLabel, searchButton, weatherImage]
        views.forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            countryName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            countryName.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250),
            countryName.widthAnchor.constraint(equalToConstant: 350),
            countryName.heightAnchor.constraint(equalToConstant: 40),
            
            countryLabel.bottomAnchor.constraint(equalTo: tempLabel.topAnchor, constant: 10),
            countryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290),
            tempLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            weatherLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             
            maxTempLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            maxTempLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100),
            
            minTempLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            minTempLabel.leadingAnchor.constraint(equalTo: maxTempLabel.trailingAnchor, constant: 40),
            
            searchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
            
            weatherImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            weatherImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 150),
            weatherImage.heightAnchor.constraint(equalToConstant: 150),
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
            tempLabel.text = "\(round(temp-273.15))°"
        }
        if let minTemp = weather.list.first?.main.temp_min {
            minTempLabel.text = "L: \(round(minTemp-273.13))°"
        }
        if let maxTemp = weather.list.first?.main.temp_max {
            maxTempLabel.text = "H: \(round(maxTemp-273.13))°"
        }
        if let weatherToday = weather.list.first?.weather.first?.main {
            weatherLabel.text = weatherToday
            if weatherToday == "Clouds" {
                weatherImage.image = UIImage(systemName: "cloud.fill")
            } else if weatherToday == "Clear" {
                weatherImage.image = UIImage(systemName: "sun.max")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
            } else if weatherToday == "Rain" {
                weatherImage.image = UIImage(systemName: "cloud.rain")
            } else if weatherToday == "Wind" {
                weatherImage.image = UIImage(systemName: "wind")
            }
        }
        countryLabel.text = countryName.text
    }
}


