//
//  ArticleListRepositoryTests.swift
//  NYTimesAppTests
//
//  Created by Muhammad Iqbal on 02/02/2025.
//

import XCTest
@testable import NYTimesApp

class ArticleListRepositoryTests: XCTestCase {
    
    var repository: MockArticleListRepository!

    override func setUp() {
        super.setUp()
        repository = MockArticleListRepository()
    }

    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func testFetchArticles_Success() {
        // Arrange
        let expectedArticles = [Article(url: "https://example.com", id: 1, title: "Test Article")]
        repository.result = .success(expectedArticles)
        
        // Act
        repository.fetchArticles(endpoint: EndPoint.mostViewedEndpoint(section: "all-sections", period: 7)) { result in
            switch result {
            case .success(let articles):
                // Assert
                XCTAssertEqual(articles?.count, expectedArticles.count)
                XCTAssertEqual(articles?.first?.title, "Test Article")
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }
    
    func testFetchArticles_Failure() {
        // Arrange
        repository.result = .failure(.serverError(500))

        // Act
        repository.fetchArticles(endpoint: EndPoint.mostViewedEndpoint(section: "all-sections", period: 7)) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                // Assert
                XCTAssertEqual(error, .serverError(500))
            }
        }
    }
}
