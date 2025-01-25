//
//  CastView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct CastView: View {
    var castContent: CastModel?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let cast = castContent?.cast {
                Text("Cast")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(nil)
                ForEach(cast, id: \.self) { detail in
                    HStack(alignment: .center, spacing: 4.0) {
                        if let imageUrl = detail.profilePath {
                            AsyncImageLoaderView(imageUrl: "https://image.tmdb.org/t/p/w500\(imageUrl)")
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: 40, maxHeight: 40)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                        }
                        Text(detail.name)
                            .font(.body)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
    }
}

//#Preview {
//    CastView()
//}
