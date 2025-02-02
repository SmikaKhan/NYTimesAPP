//
//  ImageCardView.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import SwiftUI

struct ImageCardView: View {
    let imageUrl: String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray.opacity(0.1))
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            SwiftUIImageView(urlString: imageUrl)
                .frame(height: 200)
                .cornerRadius(12)
                .shadow(radius: 5)
        }
        .padding(.horizontal)
    }
}
