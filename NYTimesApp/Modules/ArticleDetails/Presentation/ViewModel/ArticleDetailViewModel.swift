//
//  ArticleDetailViewModel.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import Foundation

protocol ArticleDetailViewModelProtocol {
    var articleDetailModel: ArticleDetailModel { get }
}

class ArticleDetailViewModel: ArticleDetailViewModelProtocol {
    
    var articleDetailModel: ArticleDetailModel
    
    init(articleDetailModel: ArticleDetailModel) {
        self.articleDetailModel = articleDetailModel
    }
}
