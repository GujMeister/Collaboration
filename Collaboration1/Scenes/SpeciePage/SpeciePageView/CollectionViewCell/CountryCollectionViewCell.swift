//
//  CountryCollectionViewCell.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import UIKit

final class CountryCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "CardCollectionViewCell"
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "FiraGo", size: 16)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        let bulliedAndCompressedView = UIView()
        
        let descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "FiraGo", size: 10)
        descriptionLabel.textColor = UIColor(hex: "5E6272")
        descriptionLabel.numberOfLines = 0

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(bulliedAndCompressedView)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var imageView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(labelStackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            labelStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2),
        ])
    }
    
    // MARK: - Configure Cell
    func configureCell(with emoji: String, text1: String, text2: String) {
        imageView.text = emoji
        
        guard let titleLabel = labelStackView.arrangedSubviews[0] as? UILabel,
              let descriptionLabel = labelStackView.arrangedSubviews[1] as? UILabel else {
            return
        }
        
        titleLabel.text = text1
        descriptionLabel.text = text2
    }
}
