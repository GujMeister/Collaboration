//
//  populationPageExtension.swift
//  Collaboration1
//
//  Created by ana namgaladze on 17.05.24.
//

import UIKit
// MARK: - UISearchBarDelegate

extension PopulationPageVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCountries(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.resetFilter()
    }
}

// MARK: - UITableViewDelegate

extension PopulationPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = dataSource.itemIdentifier(for: indexPath) ?? ""
        viewModel.fetchCountryInformation(for: country)
    }
}

// MARK: - PopulationViewModelDelegate

extension PopulationPageVC: PopulationViewModelDelegate {
    func didUpdateCountries(_ countries: [String]) {
        applySnapshot(for: countries)
    }
    
    func didFetchCountryInformation(_ information: String, for country: String) {
        let message = "\(country)\n\n\(information)"
        showCustomAlert(message: message)
    }
    
    func didFailToFetchCountryInformation(withError error: Error) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "🚨", message: "no information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
        print("Error fetching country information: \(error)")
    }
}

