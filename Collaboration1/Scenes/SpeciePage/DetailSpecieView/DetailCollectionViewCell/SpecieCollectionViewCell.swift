//
//  SpecieCollectionViewCell.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import UIKit
import SDWebImage

final class SpecieCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "SpeciesCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FiraGo-Bold", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let attributionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FiraGo", size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let wikipediaButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hex: "#D3D3D3")
        button.setTitle("Wikipedia", for: .normal)
        button.setTitleColor(UIColor(hex: "3C4251"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#1e2129")
        view.layer.cornerRadius = 20
        return view
    }()
    
    // MARK: - UI Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backgroundColorView)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(attributionLabel)
        contentView.addSubview(wikipediaButton)
        
        backgroundColorView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        attributionLabel.translatesAutoresizingMaskIntoConstraints = false
        wikipediaButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundColorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            attributionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            attributionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            attributionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            wikipediaButton.topAnchor.constraint(equalTo: attributionLabel.bottomAnchor, constant: 8),
            wikipediaButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
            wikipediaButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            wikipediaButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            backgroundColorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with taxon: NaturalistInfo.Taxon) {
        if let mediumUrl = taxon.defaultPhoto?.mediumUrl {
            imageView.sd_setImage(with: URL(string: mediumUrl), completed: nil)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
        } else {
            print("No Image URL for taxon: \(taxon.name ?? "Unknown")")
            imageView.image = nil
        }
        nameLabel.text = taxon.name
        attributionLabel.text = taxon.defaultPhoto?.attribution
        wikipediaButton.isHidden = taxon.wikipediaUrl == nil
    }
    
    public func setWikipediaAction(action: @escaping () -> Void) {
        wikipediaButton.addAction(UIAction { _ in action() }, for: .touchUpInside)
    }
}
