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
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a country/region"
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 76
        return tableView
    }()
    
    private(set) var viewModel: PopulationViewModel!
    private(set) var dataSource: UITableViewDiffableDataSource<Int, String>!
    
    //MARK: ---Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PopulationViewModel()
        viewModel.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
        setupUI()
        configureDataSource()
        viewModel.fetchCountries()
    }
    
    //MARK: ---Methods
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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



