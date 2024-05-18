//
//  WeatherPageVC.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import UIKit

final class WeatherPageVC: UIViewController {
    // MARK: - Variables
    let viewModel: WeatherPageVM
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Bold", size: 32)
        label.text = "Weather Forecast"
        return label
    }()
    
    private let inputLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Bold", size: 13)
        label.text = "Enter City Name"
        return label
    }()
    
    private let countryName: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .natural
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor(hex: "262A34")
        textField.textColor = .white
        textField.font = UIFont(name: "FiraGO-Bold", size: 12)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 0
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .paragraphStyle: paragraphStyle
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Example: Kutaisi", attributes: attributes)
        return textField
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.font = UIFont(name: "FiraGO-Bold", size: 25)
        label.text = "Your City"
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 60, weight: .semibold)
        label.font = UIFont(name: "FiraGO-Bold", size: 60)
        label.text = "City Temp"
        return label
    }()
    
    private var weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.font = UIFont(name: "FiraGO-Bold", size: 22)
        label.text = "Weather Conditions"
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.font = UIFont(name: "FiraGO-Bold", size: 22)
        label.text = "H: Highest Temp"
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.font = UIFont(name: "FiraGO-Bold", size: 22)
        label.text = "L: Lowest Temp"
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor(hex: "262A34")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "FiraGO-Bold", size: 22)
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
    
    //MARK: - init
    init(viewModel: WeatherPageVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    private func setupUI() {
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
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            weatherImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            weatherImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 150),
            weatherImage.heightAnchor.constraint(equalToConstant: 150),
            
            cityLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 10 ),
            cityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            tempLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            weatherLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            maxTempLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            maxTempLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -5),
            
            minTempLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            minTempLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 5),
            
            inputLabel.bottomAnchor.constraint(equalTo: countryName.topAnchor, constant: -5),
            inputLabel.leadingAnchor.constraint(equalTo: countryName.leadingAnchor, constant: 3),
            
            countryName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            countryName.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250),
            countryName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            countryName.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func searchButtonTapped() {
        guard let city = countryName.text, !city.isEmpty else {
            print("Please enter a city name.")
            let alert = UIAlertController(title: "Error", message: "Please Fill the Field Correctly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        viewModel.fetchWeather(with: city)
    }
    
    private func updateUI(with weather: WeatherForecast) {
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

