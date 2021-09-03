//
//  UIImageView+Download.swift
//  BookStoreTest_HernanAldunate
//
//  Created by user on 02/09/2021.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        guard let url = NSURL(string: url) else {
            return
        }

        ImageCache.shared.load(url: url) { [weak self] image in
            guard let image = image else {
                return
            }

            self?.image = image
        }
    }
}

