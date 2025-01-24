//
//  CastView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct CastView: View {
    var detailContent: [[String: String]]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cast")
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(nil)
            ForEach(detailContent, id: \.self) { detail in
                HStack(alignment: .center, spacing: 4.0) {
                    if let imageUrl = detail["image"] {
                        if imageUrl == "" {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: 40, maxHeight: 40)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                        } else {
                            AsyncImageLoaderView(imageUrl: imageUrl)
                        }
                    }
                    Text(detail["name"]!)
                        .font(.body)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

//#Preview {
//    CastView()
//}
