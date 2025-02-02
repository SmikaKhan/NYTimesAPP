//
//  SwiftUIImageView.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import SwiftUI
import UIKit

struct SwiftUIImageView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        if urlString.isEmpty {
            uiView.image = UIImage(named: "detailsThumbPlaceholder")
            return
        }
        uiView.loadImage(fromUrl: urlString)
    }
}
