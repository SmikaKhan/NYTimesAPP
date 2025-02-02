//
//  UIImageView+Extension.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit

extension UIImageView {
    func loadImage(fromUrl urlString: String) {
        guard let imageURL = URL(string: urlString) else { return }
        ImageCache.loadImage(from: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
