//
//  AsyncImageLoaderView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct AsyncImageLoaderView: View {
    var imageUrl: String
    var maxWidth: CGFloat = 50
    var maxHeight: CGFloat = 50
    
    var body: some View {
        if imageUrl == "" {
            Image(.no)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        } else {
            AsyncImage(
                url: URL(string: imageUrl),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
}

//#Preview {
//    AsyncImageLoaderView()
//}
