//
//  AricleListCoordinator.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit

protocol AricleListCoordinatorProtocol {
    func navigateToDetails(_ articleDetailModel: ArticleDetailModel)
}


class AricleListCoordinator: AricleListCoordinatorProtocol {
   
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([ArticleListViewController.builder(coordinator: self)], animated: false)
    }
    
    func navigateToDetails(_ articleDetailModel: ArticleDetailModel) {
        let detailsCoordinator = ArticleDetailCoordinator(navigationController: navigationController, articleDetailModel: articleDetailModel)
        detailsCoordinator.start()
    }
    
}
