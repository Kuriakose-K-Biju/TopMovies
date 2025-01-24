//
//  MovieDetailsView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    let castDetails: [[String: String]] = [["name": "Daniel Brühl", "image": "https://image.tmdb.org/t/p/w500/3YlmTfiy5qZXkrdKGjaM1uMjGKP.jpg"],
                                            ["name": "Anabelle Lachatte", "image": "https://image.tmdb.org/t/p/w500/c8VSEDDBO9xJoJ4AXknb4NA054v.jpg"],
                                            ["name": "Patrick Joswig", "image": "https://image.tmdb.org/t/p/w500/hJMSqMjOvs1U8XizJfn7k2HcOjf.jpg"],
                                            ["name": "Katharina Schüttler", "image": "https://image.tmdb.org/t/p/w500/flIGG4GZ1r8IsrpvsuVV0LegK59.jpg"],
                                            ["name": "Ilse Strambowski", "image": ""]]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12.0) {
                    AsyncImageLoaderView(imageUrl: "https://image.tmdb.org/t/p/w500/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
                                         maxWidth: .infinity,
                                         maxHeight: 350)
                    DetailContentView(title: "Movie Name", value: "The Shawshank Redemption")
                    DetailContentView(title: "Synopsis", value: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
                    CastView(detailContent: castDetails)
                    DetailContentView(title: "User Rating", value: "⭐️8.7")
                    DetailContentView(title: "Production Company", value: "Castle Rock Entertainment")
                    DetailContentView(title: "Release Date", value: "23 July 1994")
                }
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 20.0, trailing: 8.0))
            }.clipped()
            .navigationTitle("Movie Details")
        }
    }
}

#Preview {
    MovieDetailsView()
}
