//
//  ArticleDetailCoordinator.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit

protocol ArticleDetailCoordinatorProtocol {
    func popDetails()
}

class ArticleDetailCoordinator: ArticleDetailCoordinatorProtocol {
   
    private let navigationController: UINavigationController
    private let articleDetailModel: ArticleDetailModel
    
    init(navigationController: UINavigationController, articleDetailModel: ArticleDetailModel) {
        self.navigationController = navigationController
        self.articleDetailModel = articleDetailModel
    }
    
    func start() {
        navigationController.pushViewController(ArticleDetailViewController.builder(articleDetailModel: articleDetailModel), animated: true)
    }
    
    func popDetails() {
        navigationController.popViewController(animated: true)
    }
}
