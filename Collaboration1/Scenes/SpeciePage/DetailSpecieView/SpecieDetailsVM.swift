//
//  SpecieDetailsVM.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import Foundation
import SimpleNetworking

final class SpecieDetailsVM {
    
    private var cityID: Int? {
        didSet {
            print(cityID as Any)
            if let cityID = cityID {
                fetchNatureInfo(with: cityID)
            }
        }
    }
    
    internal var species: [NaturalistInfo.Taxon] = [] {
        didSet {
            onSpeciesInfoUpdate?(species)
        }
    }
    
    var onSpeciesInfoUpdate: (([NaturalistInfo.Taxon]) -> Void)?
    
    
    internal func fetchCityID(with passedCountry: String) {
        WebService().fetchData(from: "https://api.inaturalist.org/v1/places/autocomplete?q=\(passedCountry)", resultType: CityIDModel.self) { result in
            switch result {
            case .success(let cityIDModel):
                self.cityID = cityIDModel.results?.first?.id
                print("City ID: \(self.cityID ?? 0)")
            case .failure(let error):
                print("Error fetching city ID: \(error)")
            }
        }
    }
    
    private func fetchNatureInfo(with cityID: Int) {
        WebService().fetchData(from: "https://api.inaturalist.org/v1/observations/species_counts?place_id=\(cityID)", resultType: NaturalistInfo.NaturalistInfoModel.self) { result in
            switch result {
            case .success(let speciesInfo):
                if let results = speciesInfo.results {
                    let mappedResults = results.compactMap { $0.taxon }
                    self.species = mappedResults
                }
            case .failure(let error):
                print("Error fetching species info: \(error)")
            }
        }
    }
}
