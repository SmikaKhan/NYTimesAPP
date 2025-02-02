//
//  AppCoordinator.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit
class AppCoordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let articlesCoordinator: AricleListCoordinator
    private let networkReachablityProtocol: NetworkReachablityProtocol

    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.networkReachablityProtocol = NetworkReachablity()
        self.articlesCoordinator = AricleListCoordinator(navigationController: navigationController)
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        articlesCoordinator.start()
    }
}
