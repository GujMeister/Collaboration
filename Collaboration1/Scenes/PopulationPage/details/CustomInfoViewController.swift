//
//  CustomInfoViewController.swift
//  Collaboration1
//
//  Created by ana namgaladze on 17.05.24.
//
//
import UIKit

final class CustomInfoViewController: UIViewController {
    var viewModel: CustomInfoViewModel!
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "FiraGO-Bold", size: 25)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "FiraGO-Regular", size: 25)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#262A34")
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#3C4251")
        
        okButton.setTitle("OK", for: .normal)
        okButton.addAction(UIAction(handler: { _ in
            self.dismissAlert()
        }), for: .touchUpInside)
        
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(okButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.processMessage()
    }
    
     func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: ---extension
extension CustomInfoViewController: CustomInfoViewModelDelegate {
    func didUpdateMessage(_ message: String) {
        messageLabel.text = message
    }
}

extension UIViewController {
    func showCustomAlert(message: String) {
        DispatchQueue.main.async {
            let customAlert = CustomInfoViewController()
            customAlert.viewModel = CustomInfoViewModel(message: message)
            customAlert.modalPresentationStyle = .overFullScreen
            self.present(customAlert, animated: true, completion: nil)
        }
    }
}
