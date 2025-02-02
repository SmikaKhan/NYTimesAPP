//
//  ArticleDetailViewController.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit
import SwiftUI

class ArticleDetailViewController: UIViewController {

    let viewModel: ArticleDetailViewModelProtocol
    
    init(viewModel: ArticleDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("controller not initilized")
    }
    
    deinit {
        print("ArticleDetailViewController deinitialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addSwiftUIView()

        // Do any additional setup after loading the view.
    }
    
    private func addSwiftUIView() {
        let articleDetailView = ArticleDetailView(viewModel: DetailsUIViewModel(articleDetailModel: self.viewModel.articleDetailModel))
        let hostingController = UIHostingController(rootView: articleDetailView)
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
    }
    
}

extension ArticleDetailViewController {
    
    static func builder(articleDetailModel: ArticleDetailModel) -> ArticleDetailViewController {
        let viewModel = ArticleDetailViewModel(articleDetailModel: articleDetailModel)
        return ArticleDetailViewController(viewModel: viewModel)
    }
}
