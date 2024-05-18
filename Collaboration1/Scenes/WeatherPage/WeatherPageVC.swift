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
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.font = UIFont(name: "FiraGO-Bold", size: 22)
        label.text = "Weather Forecast"
        return label
    }()
    private let inputLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.font = UIFont(name: "FiraGO-Bold", size: 13)
        label.text = "Enter City Name"
        return label
    }()
    private let countryName: UITextField = {
        var placeHolderColor = UIColor.white
        placeHolderColor = UIColor(white: 1, alpha: 0.5)
        let textField = UITextField()
        textField.placeholder = "Example: Kutaisi"
        textField.attributedPlaceholder = NSAttributedString(
            string: "Example: Kutaisi",
            attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor]
        )
        textField.textAlignment = .natural
        textField.layer.cornerRadius = 2
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hex: "262A34").cgColor
        textField.textColor = .white
        textField.font = UIFont(name: "FiraGO-Bold", size: 12)
        return textField
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.font = UIFont(name: "FiraGO-Bold", size: 25)
        return label
    }()
   
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 60, weight: .semibold)
        label.font = UIFont(name: "FiraGO-Bold", size: 60)
        return label
    }()
    
    private var weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.font = UIFont(name: "FiraGO-Bold", size: 22)
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.font = UIFont(name: "FiraGO-Bold", size: 22)
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.font = UIFont(name: "FiraGO-Bold", size: 22)
        return label
    }()
    
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor(hex: "262A34")
        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private  let weatherImage: UIImageView = {
        let colours = [UIColor.red, UIColor.yellow, UIColor.red]
        let configuration = UIImage.SymbolConfiguration(paletteColors: colours)
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "thermometer.sun")?.applyingSymbolConfiguration(configuration)
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
        let views = [ countryName, cityLabel, tempLabel, weatherLabel, maxTempLabel, minTempLabel, searchButton, weatherImage, titleLabel, inputLabel]
        views.forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        searchButton.addAction(UIAction(handler: { _ in
            self.searchButtonTapped()
        }), for: .touchUpInside)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 53),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            inputLabel.bottomAnchor.constraint(equalTo: countryName.topAnchor, constant: -5),
            inputLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            
            countryName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            countryName.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250),
            countryName.widthAnchor.constraint(equalToConstant: 350),
            countryName.heightAnchor.constraint(equalToConstant: 40),
            
            cityLabel.bottomAnchor.constraint(equalTo: tempLabel.topAnchor, constant: -3),
            cityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
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
    func searchButtonTapped() {
        guard let city = countryName.text, !city.isEmpty else {
            print("Please enter a city name.")
            let alert = UIAlertController(title: "Error", message: "Please Fill the Field Correctly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
                weatherImage.image = UIImage(systemName: "cloud.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            } else if weatherToday == "Clear" {
                weatherImage.image = UIImage(systemName: "sun.max")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
            } else if weatherToday == "Rain" {
                let colours = [UIColor.white, UIColor.blue]
                let configuration = UIImage.SymbolConfiguration(paletteColors: colours)
                weatherImage.image = UIImage(systemName: "cloud.rain")?.applyingSymbolConfiguration(configuration)
            } else if weatherToday == "Wind" {
                weatherImage.image = UIImage(systemName: "wind")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            }
        }
        cityLabel.text = countryName.text
    }
}


