//
//  CustomCell.swift
//  Collaboration1
//
//  Created by ana namgaladze on 17.05.24.
//
//
import UIKit

final class CustomCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    //MARK: ---Properties
     lazy var rectangleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        updateAppearance(for: view)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FiraGO-Bold", size: 16)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(rectangleView)
        rectangleView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            rectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            rectangleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            rectangleView.heightAnchor.constraint(equalToConstant: 60),
        
            titleLabel.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor)
        ])
    }
    
    // MARK: - Trait Changes
    
    private func updateAppearance(for view: UIView) {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            view.layer.borderColor = UIColor { traitCollection -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }.cgColor
        } else {
            view.backgroundColor = .white
            view.layer.borderColor = UIColor.black.cgColor
        }
    }

    // MARK: - Prepare for Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateAppearance(for: rectangleView)
    }
}
