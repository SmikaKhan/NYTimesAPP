//
//  ArticleListViewController.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 31/01/2025.
//

import UIKit
import Combine

class ArticleListViewController: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    var viewModel: ArticleListViewModelProtocol
    var coordinator: AricleListCoordinatorProtocol!
    private var cancellables = Set<AnyCancellable>()
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: ArticleListViewModelProtocol, coordinator: AricleListCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("controller not initilized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        showActivityIndicator()
        
    }
    
    private func setupUI() {
        title = "Most Popular Articles"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(ofType: ArticleCell.self)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    
    private func bindViewModel() {
        self.viewModel.articlesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] articles in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        self.viewModel.errorPublisher
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showAlert(title: "Error", message: errorMessage)
            }
            .store(in: &cancellables)
        
        self.viewModel.hideActivityIndicator
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoaderHidder in
                if isLoaderHidder {
                    self?.hideActivityIndicator()
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func refreshData() {
        self.viewModel.fetchArticles()
    }
    
}


extension ArticleListViewController {
    
    static func builder(coordinator: AricleListCoordinatorProtocol) -> ArticleListViewController{
        let repository = ArticleListRepository(networkManager: NetworkManager())
        let viewModel = ArticleListViewModel(networkReachabilityService: NetworkReachablity(), repository: repository)
        let viewController = ArticleListViewController(viewModel: viewModel, coordinator: coordinator)
        return viewController
    }
}

