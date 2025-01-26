//
//  AsyncImageLoaderView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct AsyncImageLoaderView: View {
    
    @ObservedObject var imageLoader: ImageLoader
    var imageUrl: String
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    
    init(imageUrl: String, maxWidth: CGFloat = 50, maxHeight: CGFloat = 50) {
        self.imageLoader = ImageLoader(url: imageUrl)
        self.imageUrl = imageUrl
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
    
    var body: some View {
        if imageUrl == "" {
            Image(.no)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        } else {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            } else {
                ProgressView()
            }
        }
    }
}

//#Preview {
//    AsyncImageLoaderView()
//}
