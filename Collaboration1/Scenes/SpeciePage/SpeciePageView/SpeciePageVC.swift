//
//  SpeciePageVC.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import UIKit

final class SpeciePageVC: UIViewController {
    // MARK: - Properties
    private let viewModel: SpeciePageVM
    
    private var isSearching = false
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Bold", size: 24)
        label.text = "Explore Countries Species"
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: CountryCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Countries"
        searchBar.barTintColor = UIColor(hex: "#3C4251")
        
        searchBar.searchTextField.textColor = .white
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            let placeholderText = searchBar.placeholder ?? ""
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
            )
            
            if let leftView = searchTextField.leftView as? UIImageView {
                leftView.tintColor = .white
            }
        }
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(hex: "#3C4251").cgColor
        
        
        return searchBar
    }()
    
    //MARK: ---init
    init(viewModel: SpeciePageVM) {
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
        bindViewModel()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#3C4251")
        
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.onFilteredCountriesUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SpeciePageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = !searchText.isEmpty
        viewModel.filterCountries(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        viewModel.filterCountries(with: "")
    }
}

// MARK: - Data Source
extension SpeciePageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.reuseIdentifier, for: indexPath) as? CountryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let (country, (flagEmoji, capital)) = viewModel.getCountry(at: indexPath.row)
        
        cell.configureCell(with: flagEmoji, text1: country, text2: capital)
        
        cell.backgroundColor = UIColor(hex: "262A34")
        cell.layer.cornerRadius = 10
        
        return cell
    }
}

// MARK: - Delegate Flow Layout
extension SpeciePageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3
        let spacingBetweenItems: CGFloat = 5
        
        let totalSpacing = (2 * spacingBetweenItems) + ((numberOfItemsPerRow - 1) * spacingBetweenItems)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        
        return CGSize(width: width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

// MARK: - Delegate
extension SpeciePageVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let (selectedCountry, _) = viewModel.getCountry(at: indexPath.row)
        navigateToSpecieDetails(with: selectedCountry)
    }
    
    func navigateToSpecieDetails(with country: String) {
        let specieDetailsVC = SpecieDetailsVC()
        specieDetailsVC.viewModel.fetchCityID(with: country)
        self.present(specieDetailsVC, animated: true)
    }
}
