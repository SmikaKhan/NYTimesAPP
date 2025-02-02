//
//  ArticleListRepository.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 02/02/2025.
//

import Foundation

protocol ArticleListRepositoryProtocol {
    func fetchArticles(endpoint: EndpointProtocol,completion: @escaping (Result<[Article]?, NetworkError>) -> Void)
}

class ArticleListRepository: ArticleListRepositoryProtocol {
   
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    func fetchArticles(endpoint: EndpointProtocol, completion: @escaping (Result<[Article]?, NetworkError>) -> Void) {
        networkManager.request(endpoint: endpoint, method: .get) { (result: Result<NYTResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
