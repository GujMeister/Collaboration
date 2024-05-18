//
//  NaturalistInfoMode.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import Foundation

// MARK: - NaturalistInfo

public class NaturalistInfo {
    struct NaturalistInfoModel: Decodable, Hashable {
        let results: [Result]?
        
        enum CodingKeys: String, CodingKey {
            case results
        }
        
        // Conformance to Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(results)
        }
        
        static func == (lhs: NaturalistInfoModel, rhs: NaturalistInfoModel) -> Bool {
            return lhs.results == rhs.results
        }
    }
    
    // MARK: - Result
    struct Result: Decodable, Hashable {
        let taxon: Taxon?
        
        // Conformance to Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(taxon)
        }
        
        static func == (lhs: Result, rhs: Result) -> Bool {
            return lhs.taxon == rhs.taxon
        }
    }
    
    // MARK: - Taxon
    struct Taxon: Decodable, Hashable {
        let name: String?
        let defaultPhoto: DefaultPhoto?
        let wikipediaUrl: String?

        enum CodingKeys: String, CodingKey {
            case name
            case defaultPhoto = "default_photo"
            case wikipediaUrl = "wikipedia_url"
        }
        
        // Conformance to Hashable
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(defaultPhoto)
            hasher.combine(wikipediaUrl)
        }
        
        static func == (lhs: Taxon, rhs: Taxon) -> Bool {
            return lhs.name == rhs.name &&
                lhs.defaultPhoto == rhs.defaultPhoto &&
                lhs.wikipediaUrl == rhs.wikipediaUrl
        }
    }
    
    // MARK: - DefaultPhoto
    struct DefaultPhoto: Decodable, Hashable {
        let attribution: String?
        let mediumUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case attribution
            case mediumUrl = "medium_url"
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(attribution)
            hasher.combine(mediumUrl)
        }
        
        static func == (lhs: DefaultPhoto, rhs: DefaultPhoto) -> Bool {
            return lhs.attribution == rhs.attribution &&
                lhs.mediumUrl == rhs.mediumUrl
        }
    }
}
