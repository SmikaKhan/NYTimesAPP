//
//  MockArticleListRepositoy.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 02/02/2025.
//

import Foundation

class MockArticleListRepository: ArticleListRepositoryProtocol {
    
    var result: Result<[Article]?, NetworkError>?

    func fetchArticles(endpoint: EndpointProtocol, completion: @escaping (Result<[Article]?, NetworkError>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
