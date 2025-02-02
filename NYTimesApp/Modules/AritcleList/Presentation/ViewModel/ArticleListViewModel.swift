//
//  ArticleListViewModel.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 31/01/2025.
//

import Foundation
import Combine

protocol ArticleListViewModelProtocol {
    func fetchArticles()
    var articlesPublisher: Published<[Article]>.Publisher { get }
    var errorPublisher: Published<String?>.Publisher { get }
    func article(forIndex index: Int) -> Article?
    var hideActivityIndicator: PassthroughSubject<Bool, Never> { get }
    func numberOfRows() -> Int
    func getArticleDetalModel(selectedArticle: Article) -> ArticleDetailModel
}

class ArticleListViewModel: ArticleListViewModelProtocol{
    var cancellables = Set<AnyCancellable>()
    var articlesPublisher: Published<[Article]>.Publisher {
        $articles
    }
    var errorPublisher: Published<String?>.Publisher {
        $errorMessage
    }

    @Published private(set) var articles: [Article] = []
    @Published private(set) var errorMessage: String?
    var hideActivityIndicator = PassthroughSubject<Bool, Never>()
    private let networkReachabilityService: NetworkReachablityProtocol
    private let repository: ArticleListRepositoryProtocol
    // MARK: - Init
    init(networkReachabilityService: NetworkReachablityProtocol, repository: ArticleListRepositoryProtocol) {
        self.networkReachabilityService = networkReachabilityService
        self.repository = repository
        self.fetchArticles()
    }
    
    // Simulate fetching data
    func fetchArticles() {
        guard networkReachabilityService.isReachable else {
            errorMessage = ArticleListStrings.noInternetConnection
            return
        }
        self.repository.fetchArticles(endpoint: EndPoint.mostViewedEndpoint(section: ArticleListStrings.allSectionsKey, period: 7)) { [weak self] (result: Result<[Article]?, NetworkError>) in
            self?.hideActivityIndicator.send(true)
            switch result {
            case .success(let articles):
                self?.articles = articles ?? []
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    private func handleError(error: NetworkError) {
        switch error {
        case .decodingError(let decodingError):
            self.errorMessage = decodingError.localizedDescription
        case .invalidURL:
            self.errorMessage = ArticleListStrings.invalidURL
        case .noData:
            self.errorMessage = ArticleListStrings.noDataAvailable
        case .serverError( _):
            self.errorMessage = ArticleListStrings.serverError
        case .other(let otherError):
            self.errorMessage = otherError.localizedDescription
        }
    }
    
    func article(forIndex index: Int) -> Article? {
        guard index >= 0 && index < articles.count else { return nil }
        return articles[index]
    }
    
    func numberOfRows() -> Int {
        articles.count
    }
    
    func getArticleDetalModel(selectedArticle: Article) -> ArticleDetailModel {
        ArticleDetailModel(detailViewThumbUrl: selectedArticle.detailViewThumb ?? "", cardDetailsUIModel: CardDetailsUIModel(title: selectedArticle.title ?? "", abstract: selectedArticle.abstract ?? "", author: selectedArticle.author ?? "", publishedData: selectedArticle.publishedDate ?? "", articleUrl: selectedArticle.url ?? ""))
    }
}

fileprivate struct ArticleListStrings {
    static let invalidURL = "Invalid URL"
    static let allSectionsKey = "all-sections"
    static let noInternetConnection = "No internet connection."
    static let noDataAvailable = "no data available"
    static let serverError = "Something went wrong, please try again!"
}
