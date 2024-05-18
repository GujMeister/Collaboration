//
//  CityIDModel.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import Foundation

// MARK: - CityIDModel
struct CityIDModel: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
}
