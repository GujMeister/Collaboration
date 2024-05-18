//
//  AirQualityPageVC.swift
//  Collaboration1
//
//  Created by Ana on 5/17/24.
//

import UIKit

class AirQualityPageVC: UIViewController {
    
    private let viewModel: AirQualityViewModel
    var countries: [String]?
    var states: [String]?
    var cities: [String]?
    var selectedCountry: String?
    var selectedState: String?
    var selectedCity: String?
    
    // MARK: - Initialization

    init(viewModel: AirQualityViewModel, countries: [String]? = nil, states: [String]? = nil, cities: [String]? = nil, selectedCountry: String? = nil, selectedState: String? = nil, selectedCity: String? = nil) {
        self.viewModel = viewModel
        self.countries = countries
        self.states = states
        self.cities = cities
        self.selectedCountry = selectedCountry
        self.selectedState = selectedState
        self.selectedCity = selectedCity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Image")
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "City's Air Quality"
        label.font = UIFont(name:"FiraGO-Bold", size: 30)
        return label
    }()
    
    lazy var countryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Country"
        textField.backgroundColor = UIColor(hex: "#262A34")
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.borderStyle = .none
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.inputView = countryPickerView
        textField.inputAccessoryView = pickerViewToolbar

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select Country", attributes: placeholderAttributes)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevronImageView.tintColor = .white
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        chevronImageView.center = rightView.center
        rightView.addSubview(chevronImageView)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()

    lazy var stateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select State"
        textField.backgroundColor = UIColor(hex: "#262A34")
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.borderStyle = .none
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.inputView = statePickerView
        textField.inputAccessoryView = pickerViewToolbar

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select State", attributes: placeholderAttributes)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevronImageView.tintColor = .white
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        chevronImageView.center = rightView.center
        rightView.addSubview(chevronImageView)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()

    lazy var cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select City"
        textField.backgroundColor = UIColor(hex: "#262A34")
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.borderStyle = .none
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.inputView = cityPickerView
        textField.inputAccessoryView = pickerViewToolbar

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select City", attributes: placeholderAttributes)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevronImageView.tintColor = .white
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        chevronImageView.center = rightView.center
        rightView.addSubview(chevronImageView)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()


    lazy var fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate Air Quality", for: .normal)
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
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#3C4251")
        setupViews()
        
        viewModel.delegate = self
        fetchCountries()
    }
    
    // MARK: - Setup Views

    private func setupViews() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])


        view.addSubview(countryTextField)
        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
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
            fetchButton.heightAnchor.constraint(equalToConstant: 40),
            fetchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        ])
        
        view.addSubview(airQualityLabel)
        airQualityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            airQualityLabel.topAnchor.constraint(equalTo: fetchButton.bottomAnchor, constant: 30),
            airQualityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            airQualityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Fetch Countries Function + showAlert Function

    private func fetchCountries() {
        let apiKey = "9491b1c0-d840-4ca0-a8a1-7ed13b629f4c"
        viewModel.fetchCountries(apiKey: apiKey)
    }
    
    @objc private func fetchButtonTapped() {
        guard let country = selectedCountry,
              let state = selectedState,
              let city = selectedCity, !city.isEmpty else {
            showAlert("🥺 Please fill in all fields 🥺")
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

#Preview {
    AirQualityPageVC(viewModel: AirQualityViewModel())
}
