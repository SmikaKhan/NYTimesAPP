//
//  EndPoint.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum EndPoint: EndpointProtocol {
    
    case mostViewed(section: String, period: Int, apiKey: String)
    var scheme: String {
        "https"
    }
    var host: String {
        "api.nytimes.com"
    }
    var basePath: String {
        "/svc/mostpopular/v2"
    }
    
    var path: String {
        switch self {
        case .mostViewed(let section, let period, _):
            return "\(basePath)/mostviewed/\(section)/\(period).json"
        }
    }
    
    var queryItems: [QueryItem]? {
        switch self {
        case .mostViewed(_, _, let apiKey):
            return [
                QueryItem(key: "api-key", value: apiKey)
            ]
        }
        
    }
    
    // Factory method to create an endpoint, handling API key retrieval
    static func mostViewedEndpoint(section: String, period: Int) -> EndPoint {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Key not found")
        }
        return .mostViewed(section: section, period: period, apiKey: apiKey)
    }
    
    
}

struct QueryItem {
    let key: String
    let value: String
}

protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [QueryItem]? { get }
    static func mostViewedEndpoint(section: String, period: Int) -> EndPoint
}
