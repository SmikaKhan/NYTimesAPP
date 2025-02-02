//
//  DetailsViewModel.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import Foundation

protocol DetailsViewModelProtocol: ObservableObject {
    var articleDetailModel: ArticleDetailModel { get }
}


class DetailsUIViewModel: DetailsViewModelProtocol {
    
    var articleDetailModel: ArticleDetailModel
    
    init(articleDetailModel: ArticleDetailModel) {
        self.articleDetailModel = articleDetailModel
    }
}
