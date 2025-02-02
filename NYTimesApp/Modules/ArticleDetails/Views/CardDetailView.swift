//
//  CardDetailView.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import SwiftUI

struct CardDetailsView: View {
    let cardDetailModel: CardDetailsUIModel
    var body: some View {
        Text(cardDetailModel.title)
            .font(.title2)
            .foregroundColor(NYTimesColor.articleTitleColor.color)
            .fontWeight(.bold)
            .padding(.horizontal)
        
        Text(cardDetailModel.abstract)
            .font(.body)
            .foregroundColor(NYTimesColor.subTitleColor.color)
            .padding(.horizontal)
        
        HStack {
            Text(cardDetailModel.author)
                .font(.footnote)
                .foregroundColor(NYTimesColor.subTitleColor.color)
            Spacer()
            Text(cardDetailModel.publishedData)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        Spacer()
        Button(action: {
            guard let url = URL(string: cardDetailModel.articleUrl) else { return }
            UIApplication.shared.open(url)
        }) {
            Text("Read Full Article")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(NYTimesColor.buttonBackgroundColor.color)
                .foregroundColor(NYTimesColor.buttonTitleColor.color)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 3)
                .padding(.horizontal)
        }
    }
}
