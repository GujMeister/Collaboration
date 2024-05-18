//
//  PopulationPageVC.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//
//
import UIKit

final class PopulationPageVC: UIViewController {
    //MARK: ---Properties
    lazy var headerTitle: UILabel = {
        let title = UILabel()
        title.text = "Population"
        title.textColor = .white
        title.font = UIFont(name: "FiraGO-Bold", size: 30)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a country/region"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor(hex: "#3C4251")
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
        searchBar.searchTextField.textColor = .white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(hex: "#3C4251").cgColor
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 76
        tableView.backgroundColor = UIColor(hex: "#3C4251")
        return tableView
    }()
    
    private(set) var viewModel: PopulationViewModel
    private(set) var dataSource: UITableViewDiffableDataSource<Int, String>!
    
    //MARK: ---init
    init(viewModel: PopulationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ---Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
        setupUI()
        configureDataSource()
        viewModel.fetchCountries()
    }
    
    //MARK: ---Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#3C4251")
        view.addSubview(headerTitle)
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: headerTitle.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView) { tableView, indexPath, country in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
                fatalError("Failed to dequeue CustomCell.")
            }
            cell.titleLabel.text = country
            return cell
        }
    }
    
    func applySnapshot(for countries: [String]) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
            snapshot.appendSections([0])
            snapshot.appendItems(countries)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}



