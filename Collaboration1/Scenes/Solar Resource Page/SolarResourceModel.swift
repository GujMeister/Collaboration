import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let version: String?
    let metadata: Metadata?
    let inputs: Inputs?
    let outputs: Outputs?
}

// MARK: - Inputs
struct Inputs: Codable {
    let apiKey, lat, lon: String?

    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case lat, lon
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    let sources: [String]?
}

// MARK: - Outputs
struct Outputs: Codable {
    let avgDni, avgGhi, avgLatTilt: Avg?

    enum CodingKeys: String, CodingKey {
        case avgDni = "avg_dni"
        case avgGhi = "avg_ghi"
        case avgLatTilt = "avg_lat_tilt"
    }
}

// MARK: - Avg
struct Avg: Codable {
    let annual: Double?
    let monthly: [String: Double]?
}
