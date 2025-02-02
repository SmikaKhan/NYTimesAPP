//
//  Untitled.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 31/01/2025.
//


import UIKit

// MARK: - UITableViewDataSource
extension ArticleListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ofType: ArticleCell.self, for: indexPath) else {
                return UITableViewCell()
        }
        cell.article = viewModel.article(forIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedArticle = viewModel.article(forIndex: indexPath.row) else { return }
        self.coordinator.navigateToDetails(viewModel.getArticleDetalModel(selectedArticle: selectedArticle))
    }
}
