//
//  DetailContentView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct DetailContentView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(nil)
            Text(value)
                .font(.body)
                .multilineTextAlignment(.leading)
        }
    }
}

//#Preview {
//    DetailContentView()
//}
