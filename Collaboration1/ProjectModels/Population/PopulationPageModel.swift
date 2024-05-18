//
//  PopulationPageModel.swift
//  Collaboration1
//
//  Created by ana namgaladze on 17.05.24.
//

import Foundation

struct PopulationData: Decodable {
    let totalPopulation: [PopulationRecord]
    
    enum CodingKeys: String, CodingKey {
        case totalPopulation = "total_population"
    }
}

struct PopulationRecord: Decodable, Hashable {
    let date: String
    let population: Int
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(population)
    }
    
    static func == (lhs: PopulationRecord, rhs: PopulationRecord) -> Bool {
        return lhs.date == rhs.date && lhs.population == rhs.population
    }
}


struct CountryResponse: Decodable {
    let countries: [String]
}
