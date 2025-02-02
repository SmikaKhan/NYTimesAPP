//
//  ImageCache.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import UIKit
final class ImageCache {

    private static let cacheQueue = DispatchQueue(label: "NYTimesApp.ImageCache.queue",
                                                  qos: .userInitiated,
                                                  attributes: .concurrent)
    private static let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "NYTimesApp.ImageCache"
        return cache
    }()
    
    static func cacheImage(_ image: UIImage, forKey key: String) {
        cacheQueue.async(flags: .barrier) {
            imageCache.setObject(image, forKey: key as NSString)
        }
    }
    
    static func cachedImage(forKey key: String) -> UIImage? {
        return cacheQueue.sync {
            imageCache.object(forKey: key as NSString)
        }
    }
    
    static func clearCache() {
        cacheQueue.async(flags: .barrier){
            imageCache.removeAllObjects()
        }
    }
   
    static func loadImage(from url: URL, completion: @escaping(UIImage?) -> Void) {
        
        if let cachedImage = cachedImage(forKey: url.absoluteString) {
            if Thread.isMainThread {
                completion(cachedImage)
            } else {
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
            }
            
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            cacheImage(image, forKey: url.absoluteString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        dataTask.resume()
    }
}

