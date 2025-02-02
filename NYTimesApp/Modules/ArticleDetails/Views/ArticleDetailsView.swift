//
//  ArticleDetailsView.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import SwiftUI

struct ArticleDetailView: View {
    
    @ObservedObject var viewModel: DetailsUIViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ImageCardView(imageUrl: viewModel.articleDetailModel.detailViewThumbUrl)
                CardDetailsView(cardDetailModel: viewModel.articleDetailModel.cardDetailsUIModel)
            }
        }
    }
}


