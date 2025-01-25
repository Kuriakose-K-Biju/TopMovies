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
            if let casts = castContent?.cast {
                Text("Cast")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(nil)
                if casts.isEmpty {
                    Text("No Data Available")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                } else {
                    ForEach(casts, id: \.self) { cast in
                        HStack(alignment: .center, spacing: 4.0) {
                            if cast.profilePath != nil {
                                AsyncImageLoaderView(imageUrl: cast.profileUrl)
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.gray)
                                    .frame(maxWidth: 40, maxHeight: 40)
                                    .padding(.leading, 5)
                                    .padding(.trailing, 5)
                            }
                            Text(cast.name)
                                .font(.body)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CastView()
//}
