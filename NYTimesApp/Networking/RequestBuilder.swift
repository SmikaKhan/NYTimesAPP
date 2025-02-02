//
//  RequestBuilder.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 02/02/2025.
//

import Foundation

protocol RequestBuilderProtocol {
    func buildRequest(endpoint: EndpointProtocol, method: HTTPMethod) -> URLRequest?
}

class RequestBuilder: RequestBuilderProtocol {
    func buildRequest(endpoint: EndpointProtocol, method: HTTPMethod) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        if let queryItems = endpoint.queryItems, !queryItems.isEmpty {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
