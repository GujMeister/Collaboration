//
//  WeatherPageVC.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import UIKit

class WeatherPageVC: UIViewController {
    // MARK: - Variables
    var countryText = "Kutaisi"
    let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=kutaisi&appid=159e264bbb707514e8ea1734c14e4169"
    
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
    
   
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - UI Setup
    func setupUI() {
        self.view.backgroundColor = .red
        let views = [background, countryName]
        views.forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        countryText = countryName.text!
        
        NSLayoutConstraint.activate([
            countryName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            countryName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            countryName.widthAnchor.constraint(equalToConstant: 200),
            countryName.heightAnchor.constraint(equalToConstant: 40),
            
            background.topAnchor.constraint(equalTo: self.view.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
}

