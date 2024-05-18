import UIKit
 
class SolarResourcePageVC: UIViewController, SolarResourcePageVMDelegate {
    
    // MARK: - Variables
    
    let viewModel: SolarResourcePageVM
    
    var longitudeTextField: UITextField = {
        var longitudeTextField = UITextField()
        longitudeTextField.frame = CGRect()
        longitudeTextField.clipsToBounds = true
        longitudeTextField.backgroundColor = UIColor(hex: "262A34")
        longitudeTextField.layer.cornerRadius = 10
        longitudeTextField.textAlignment = .left
        longitudeTextField.textColor = .white
        let placeholderText = "For Example: -105"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray4
        ]
        longitudeTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:longitudeTextField.frame.height))
        longitudeTextField.leftView = paddingView
        longitudeTextField.leftViewMode = .always
        return longitudeTextField
    }()
    
    var latitudeTextField: UITextField = {
        var latitudeTextField = UITextField()
        latitudeTextField.frame = CGRect()
        latitudeTextField.clipsToBounds = true
        latitudeTextField.backgroundColor = UIColor(hex: "262A34")
        latitudeTextField.placeholder = "For Example: 40"
        latitudeTextField.layer.cornerRadius = 10
        latitudeTextField.textColor = .white
        latitudeTextField.textAlignment = .left
        let placeholderText = "For Example: 40"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray4
        ]
        latitudeTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:latitudeTextField.frame.height))
        latitudeTextField.leftView = paddingView
        latitudeTextField.leftViewMode = .always
        return latitudeTextField
    }()
    
    var welcomeLabel: UILabel = {
        var welcomeLabel = UILabel()
        welcomeLabel.frame = CGRect()
        welcomeLabel.text = "Solar Resource Page"
        welcomeLabel.textColor = .white
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .left
        welcomeLabel.font = UIFont(name: "FiraGO-Bold", size: 30)
        return welcomeLabel
    }()
    
    var button: UIButton = {
        var button = UIButton(type: .system)
        button.frame = CGRect()
        button.clipsToBounds = true
        button.backgroundColor = .orange
        button.layer.cornerRadius = 20
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "FiraGO-Bold", size: 20)
        return button
    }()
    
    var longitudeTextFieldOverText: UILabel = {
        var longitudeTextFieldOverText = UILabel()
        longitudeTextFieldOverText.text = "Enter Longitude:"
        longitudeTextFieldOverText.font = UIFont(name: "FiraGO-Bold", size: 15)
        longitudeTextFieldOverText.textColor = .white
        longitudeTextFieldOverText.textAlignment = .left
        return longitudeTextFieldOverText
    }()
    
    var latitudeTextFieldOverText: UILabel = {
        var latitudeTextFieldOverText = UILabel()
        latitudeTextFieldOverText.text = "Enter Latitude:"
        latitudeTextFieldOverText.font = UIFont(name: "FiraGO-Bold", size: 15)
        latitudeTextFieldOverText.textColor = .white
        latitudeTextFieldOverText.textAlignment = .left
        return latitudeTextFieldOverText
    }()
    
    var requestedDataLabel: UILabel = {
        var requestedDataLabel = UILabel()
        requestedDataLabel.text = "Your requested data will show here:"
        requestedDataLabel.font = UIFont(name: "FiraGO-Bold", size: 20)
        requestedDataLabel.textColor = .white
        requestedDataLabel.textAlignment = .left
        return requestedDataLabel
    }()
    
    var requestedData1: UILabel = {
        var requestedData = UILabel()
        requestedData.font = UIFont(name: "FiraGO-Bold", size: 16)
        requestedData.textColor = .white
        requestedData.textAlignment = .left
        requestedData.numberOfLines = 0
        return requestedData
    }()
    
    init(viewModel: SolarResourcePageVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#3C4251")
        setupWelcomeLabel()
        setupLongitudeTextFieldOverText()
        setupLongitudeTextField()
        setupLatiitudeTextFieldOverText()
        setupLatitudeTextField()
        setupButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setupRequestedDataLabel()
    }
    
    // MARK: - Setup Functions
    
    func setupWelcomeLabel() {
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupLongitudeTextField() {
        view.addSubview(longitudeTextField)
        longitudeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            longitudeTextField.topAnchor.constraint(equalTo: longitudeTextFieldOverText.bottomAnchor, constant: 10),
            longitudeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            longitudeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            longitudeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupLatitudeTextField() {
        view.addSubview(latitudeTextField)
        latitudeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            latitudeTextField.topAnchor.constraint(equalTo: latitudeTextFieldOverText.bottomAnchor, constant: 10),
            latitudeTextField.leadingAnchor.constraint(equalTo: longitudeTextField.leadingAnchor),
            latitudeTextField.trailingAnchor.constraint(equalTo: longitudeTextField.trailingAnchor),
            latitudeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: latitudeTextField.bottomAnchor, constant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupLongitudeTextFieldOverText() {
        view.addSubview(longitudeTextFieldOverText)
        longitudeTextFieldOverText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            longitudeTextFieldOverText.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            longitudeTextFieldOverText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupLatiitudeTextFieldOverText() {
        view.addSubview(latitudeTextFieldOverText)
        latitudeTextFieldOverText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            latitudeTextFieldOverText.topAnchor.constraint(equalTo: longitudeTextField.bottomAnchor, constant: 30),
            latitudeTextFieldOverText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupRequestedDataLabel() {
        view.addSubview(requestedDataLabel)
        requestedDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestedDataLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            requestedDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupRequestedData() {
        view.addSubview(requestedData1)
        requestedData1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestedData1.topAnchor.constraint(equalTo: requestedDataLabel.bottomAnchor, constant: 25),
            requestedData1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    
    @objc func buttonTapped() {
        if let lat = latitudeTextField.text, let lon = longitudeTextField.text {
            viewModel.collectData(lon: lon, lat: lat)
        }
    }
    
    // MARK: - SolarResourcePageVMDelegate
    
    func didUpdateData() {
        DispatchQueue.main.async {
            self.requestedDataLabel.text = "Your requested Data:"
            self.setupRequestedData()
            self.requestedData1.text = """
            Average Direct Normal Irradiance: \(self.viewModel.avgDniAnnual ?? 0)
            
            Average Global Horizontal Irradiance: \(self.viewModel.avgGhiAnnual ?? 0)
            
            Average Latitude Tilt Irradiance: \(self.viewModel.avgLatTiltAnnual ?? 0)
            """
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "🚨", message: "არასწორი ლონგიტუდი და ლატიტუდი", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "არის უფროსო!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

#Preview{
    SolarResourcePageVC(viewModel: SolarResourcePageVM())
}
