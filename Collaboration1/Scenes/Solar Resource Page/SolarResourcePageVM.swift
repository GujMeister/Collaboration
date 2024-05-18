//
//  SolarResourcePage.swift
//  Collaboration1
//
//  Created by Luka Gujejiani on 17.05.24.
//

import Foundation
import SimpleNetworking

protocol SolarResourcePageVMDelegate: AnyObject {
    func didUpdateData()
    func didFailWithError(error: Error)
}

class SolarResourcePageVM {
    
    weak var delegate: SolarResourcePageVMDelegate?
    
    @Published var luka: Outputs?
    
    var longitude: String?
    var latitude: String?
    
    var avgDniAnnual: Double? {
            didSet {
                delegate?.didUpdateData()
            }
        }
        var avgGhiAnnual: Double? {
            didSet {
                delegate?.didUpdateData()
            }
        }
        var avgLatTiltAnnual: Double? {
            didSet {
                delegate?.didUpdateData()
            }
        }
    
    
    func collectData(lon: String?, lat: String?) {
        longitude = lon
        latitude = lat
        fetchwierdThings()
        print("URL: https://developer.nrel.gov/api/solar/solar_resource/v1.json?api_key=QZ69jJGeOkh1winTdbi1SCHu8NQ0eZmOLLmMauI5&lat=\(latitude ?? "")&lon=\(longitude ?? "")")
    }
    
    
    
    let webService: WebService
        
    init(webService: WebService = WebService()) {
            self.webService = webService
        }
    
    
    
    func fetchwierdThings() {
        let urlString = "https://developer.nrel.gov/api/solar/solar_resource/v1.json?api_key=QZ69jJGeOkh1winTdbi1SCHu8NQ0eZmOLLmMauI5&lat=\(latitude ?? "")&lon=\(longitude ?? "")"
        webService.fetchData(from: urlString, resultType: Welcome.self) { [weak self] result in
            switch result {
            case .success(let welcome):
                self?.luka = welcome.outputs
                self?.avgDniAnnual = welcome.outputs?.avgDni?.annual
                self?.avgGhiAnnual = welcome.outputs?.avgGhi?.annual
                self?.avgLatTiltAnnual = welcome.outputs?.avgLatTilt?.annual
                print("Avg DNI: \(welcome.outputs?.avgDni?.annual ?? 0)")
                print("Avg GHI: \(welcome.outputs?.avgGhi?.annual ?? 0)")
                print("Avg Lat Tilt: \(welcome.outputs?.avgLatTilt?.annual ?? 0)")
            case .failure(let error):
                self?.delegate?.didFailWithError(error: error)
            }
        }
    }
    
}
