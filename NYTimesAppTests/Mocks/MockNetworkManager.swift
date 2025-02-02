//
//  MockNetworkManager.swift
//  NYTimesAppTests
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
   
    var requestResult: Any?
    
    func request<T: Decodable>(endpoint: any EndpointProtocol, method: HTTPMethod, completion: @escaping (Result<T, NetworkError>) -> Void) {
        if let result = requestResult as? Result<T, NetworkError> {
            completion(result)
        }
    }
}
