//
//  DetailsViewModelTests.swift
//  NYTimesAppTests
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import XCTest
@testable import NYTimesApp

class DetailsViewModelTests: XCTestCase {

    func testInitialization_withValidArticleDetailModel() {
        // Arrange
        let articleDetailModel = ArticleDetailModel(detailViewThumbUrl: "", cardDetailsUIModel: CardDetailsUIModel(title: "Test Title", abstract: "Test abstract", author: "", publishedData: "", articleUrl: ""))
        
        // Act
        let viewModel = DetailsUIViewModel(articleDetailModel: articleDetailModel)
        
        // Assert
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.title, articleDetailModel.cardDetailsUIModel.title, "The article title should be correctly initialized.")
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.abstract, articleDetailModel.cardDetailsUIModel.abstract, "The article abstract should be correctly initialized.")
    }
    
    func testArticleDetailModel_whenChanged() {
        // Arrange
        var articleDetailModel = ArticleDetailModel(detailViewThumbUrl: "", cardDetailsUIModel: CardDetailsUIModel(title: "Test Title", abstract: "Test abstract", author: "", publishedData: "", articleUrl: ""))
        let viewModel = DetailsUIViewModel(articleDetailModel: articleDetailModel)
        
        // Act: Update the article
        articleDetailModel = ArticleDetailModel(detailViewThumbUrl: "", cardDetailsUIModel: CardDetailsUIModel(title: "Updated Title", abstract: "Updated abstract", author: "", publishedData: "", articleUrl: ""))
        
        // Assert: Ensure the article property is updated
        XCTAssertNotEqual(viewModel.articleDetailModel.cardDetailsUIModel.title, articleDetailModel.cardDetailsUIModel.title, "The article title should reflect the updated value.")
        XCTAssertNotEqual(viewModel.articleDetailModel.cardDetailsUIModel.abstract, articleDetailModel.cardDetailsUIModel.abstract, "The article abstract should reflect the updated value.")
    }
    
    func testInitialization_withEmptyArticleDetailModel() {
        // Arrange
        let articleDetailModel = ArticleDetailModel(detailViewThumbUrl: "", cardDetailsUIModel: CardDetailsUIModel(title: "", abstract: "", author: "", publishedData: "", articleUrl: ""))
        
        // Act
        let viewModel = DetailsUIViewModel(articleDetailModel: articleDetailModel)
        
        // Assert
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.title, "", "The article title should be initialized a empty.")
        XCTAssertEqual(viewModel.articleDetailModel.cardDetailsUIModel.abstract, "", "The article abstract should be initialized as empty.")
    }

}
