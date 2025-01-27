//
//  ImageCache.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 26/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()

    private init() {}

    func set(_ image: UIImage, forKey key: String) {
        MovieDataHandler().saveImage(imageUrl: key, image: image)
    }

    func get(forKey key: String) -> UIImage? {
        return MovieDataHandler().getImage(byUrl: key)
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var url: String
    private var task: URLSessionDataTask?

    init(url: String) {
        self.url = url
        loadImage()
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: url) else { return }

        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
                ImageCache.shared.set(image!, forKey: self.url)
            }
        }
        task?.resume()
    }
}
