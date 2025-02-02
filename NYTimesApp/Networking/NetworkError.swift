//
//  NetworkError.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 02/02/2025.
//

import Foundation

enum NetworkError: Error, Equatable {
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.noData, .noData):
            return true
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        case (.other(let lhsError), .other(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(Int)
    case other(Error)
}
