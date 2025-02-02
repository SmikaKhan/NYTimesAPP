//
//  ArticleDetailViewModelTests.swift
//  NYTimesAppTests
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import XCTest
@testable import NYTimesApp

class ArticleDetailViewModelTests: XCTestCase {

    // Test that the view model is initialized correctly with a valid article
    func testInitialization_withValidArticle() {
        // Arrange
        let articleDetailModel = ArticleDetailModel(detailViewThumbUrl: "", cardDetailsUIModel: CardDetailsUIModel(title: "Test Title", abstract: "This is a test abstract.", author: "", publishedData: "", articleUrl: ""))
        
        // Act
        let viewModel = ArticleDetailViewModel(articleDetailModel: articleDetailModel)
        
        // Assert
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.title, articleDetailModel.cardDetailsUIModel.title, "The article title should be correctly initialized.")
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.abstract, articleDetailModel.cardDetailsUIModel.abstract, "The article abstract should be correctly initialized.")
    }
    
    // Test that the view model is initialized correctly with an empty article
    func testInitialization_withEmptyArticle() {
        // Arrange
        let articleDetailModel = ArticleDetailModel(detailViewThumbUrl: "", cardDetailsUIModel: CardDetailsUIModel(title: "", abstract: "", author: "", publishedData: "", articleUrl: ""))
        
        // Act
        let viewModel = ArticleDetailViewModel(articleDetailModel: articleDetailModel)
        
        // Assert
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.title, "", "The article title should be initialized as empty.")
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.abstract, "", "The article abstract should be initialized as empty.")
    }
    
    // Test the correctness of the article property after initialization
    func testArticleProperty_correctlyAssigned() {
        // Arrange
        let articleDetailModel = ArticleDetailModel(detailViewThumbUrl: "", cardDetailsUIModel: CardDetailsUIModel(title: "Sample Title", abstract: "This is a sample abstract.", author: "", publishedData: "", articleUrl: ""))
        
        // Act
        let viewModel = ArticleDetailViewModel(articleDetailModel: articleDetailModel)
        
        // Assert
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.title, "Sample Title", "The article title should be 'Sample Title'.")
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.abstract, "This is a sample abstract.", "The article abstract should be 'This is a sample abstract.'")
    }
}
