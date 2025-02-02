//
//  AritcleListViewModelTests.swift
//  NYTimesAppTests
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import XCTest
@testable import NYTimesApp
import Combine

class ArticleListViewModelTests: XCTestCase {
    
    var viewModel: ArticleListViewModel!
    var mockReachability: MockNetworkReachabilityService!
    var mockRepository: MockArticleListRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockReachability = MockNetworkReachabilityService()
        mockRepository = MockArticleListRepository()
        viewModel = ArticleListViewModel(networkReachabilityService: mockReachability, repository: mockRepository)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockReachability = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    // ✅ Test: Fetch Articles Successfully
    func testFetchArticles_Success() {
        // Arrange
        let expectedArticles = [Article(url: "https://example.com", id: 1, title: "Test Article")]
        mockRepository.result = .success(expectedArticles)
        
        let expectation = XCTestExpectation(description: "Fetch articles successfully")
        
        // Act
        viewModel.fetchArticles()
        
        // Assert
        viewModel.$articles
            .dropFirst()
            .sink { articles in
                XCTAssertEqual(articles.count, expectedArticles.count)
                XCTAssertEqual(articles.first?.title, "Test Article")
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    // ✅ Test: Fetch Articles - No Internet
    func testFetchArticles_NoInternet() {
        // Arrange
        mockReachability.isReachable = false
        
        // Act
        viewModel.fetchArticles()
        
        // Assert
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorString in
                XCTAssertEqual(errorString, "No internet connection.")
            }
            .store(in: &cancellables)
        
    }
    
    // ✅ Test: Fetch Articles - No Data Error
    func testFetchArticles_NoDataError() {
        // Arrange
        mockRepository.result = .failure(.noData)
        
        let expectation = XCTestExpectation(description: "Handle no data error")
        
        // Act
        viewModel.fetchArticles()
        
        // Assert
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "no data available")
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    // ✅ Test: Fetch Articles - Server Error
    func testFetchArticles_ServerError() {
        // Arrange
        mockRepository.result = .failure(.serverError(500))
        
        let expectation = XCTestExpectation(description: "Handle server error")
        
        // Act
        viewModel.fetchArticles()
        
        // Assert
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Something went wrong, please try again!")
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    // ✅ Test: Fetch Articles - Invalid URL Error
    func testFetchArticles_InvalidURLError() {
        // Arrange
        mockRepository.result = .failure(.invalidURL)
        
        let expectation = XCTestExpectation(description: "Handle invalid URL error")
        
        // Act
        viewModel.fetchArticles()
        
        // Assert
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Invalid URL")
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    // ✅ Test: Fetch Articles - Other Error
    func testFetchArticles_OtherError() {
        // Arrange
        mockRepository.result = .failure(.other(NSError(domain: "TestError", code: 999, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
        
        let expectation = XCTestExpectation(description: "Handle other error")
        
        // Act
        viewModel.fetchArticles()
        
        // Assert
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Unknown error")
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    // ✅ Test: Get Article by Index
    func testArticleForIndex_ValidIndex() {
        // Arrange
        let expectedArticle = [Article(url: "https://example.com", id: 1, title: "Valid Article")]
        mockRepository.result = .success(expectedArticle)
        viewModel.fetchArticles()
        viewModel.$articles
            .sink { [weak self ] articles in
                guard let self = self else { return }
                // Act
                let article = self.viewModel.article(forIndex: 0)
                // Assert
                XCTAssertNotNil(article)
                XCTAssertEqual(article?.title, "Valid Article")
            }
            .store(in: &cancellables)
    }
    
    // ✅ Test: Get Article by Invalid Index
    func testArticleForIndex_InvalidIndex() {
        // Act
        let article = viewModel.article(forIndex: 5)
        
        // Assert
        XCTAssertNil(article)
    }
    
    // ✅ Test: Number of Rows
    func testNumberOfRows() {
        // Arrange
        let articles = [Article(url: "https://example.com", id: 1, title: "Article 1"),
                        Article(url: "https://example.com", id: 2, title: "Article 2")]
        mockRepository.result = .success(articles)
        
        viewModel.fetchArticles()
        
        // Act
        let rowCount = viewModel.numberOfRows()
        
        // Assert
        XCTAssertEqual(rowCount, 2)
    }
}
