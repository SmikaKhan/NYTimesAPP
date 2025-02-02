//
//  NetworkManager.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        endpoint: EndpointProtocol,
        method: HTTPMethod,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

class NetworkManager: NetworkManagerProtocol {

    private let session: URLSession
    private let requestBuilder: RequestBuilderProtocol
    
    init(session: URLSession = .shared, requestBuilder: RequestBuilderProtocol = RequestBuilder()) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
    
    func request<T: Decodable>(endpoint: any EndpointProtocol, method: HTTPMethod, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let request = requestBuilder.buildRequest(endpoint: endpoint, method: method) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}

