//
//  ImageCache.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import Foundation

import UIKit

class ImageCache {
    static let shared = ImageCache()

    private let cachedImages = NSCache<NSURL, UIImage>()

    private init() {}

    // Returns the cached image if available, otherwise asynchronously loads and caches it
    func load(url: NSURL, completion: @escaping (UIImage?) -> ()) {
        // Check for a cached image
        if let cachedImage = cachedImages.object(forKey: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }

        URLSession.shared.dataTask(with: url as URL) { [weak self] (data, response, error) in
            // Check for data and try to create the image
            guard let responseData = data,
                  let image = UIImage(data: responseData) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // Cache the image
            self?.cachedImages.setObject(image, forKey: url, cost: responseData.count)

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
