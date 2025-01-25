//
//  MovieDetailsView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject private var viewModel: MovieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.loaderEnabled {
                ProgressView("Loading...")
            } else if let error = viewModel.networkError {
                VStack {
                    Text(error.localizedDescription)
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8.0)
                    
                    Button("Retry") {
                        viewModel.getDetails()
                    }.padding(.top, 10.0).buttonStyle(.borderedProminent)
                }
            } else if let movieDetails = viewModel.movieDetails {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12.0) {
                        AsyncImageLoaderView(imageUrl: viewModel.movieImageURL,
                                             maxWidth: .infinity,
                                             maxHeight: 350)
                        DetailContentView(title: "Movie Name", value: movieDetails.title ?? "No Data Available")
                        DetailContentView(title: "Synopsis", value: movieDetails.overview ?? "No Data Available")
                        CastView(castContent: viewModel.castDetails)
                        DetailContentView(title: "User Rating", value: viewModel.movieRating)
                        DetailContentView(title: "Production Company", value: viewModel.productionCompany)
                        DetailContentView(title: "Release Date", value: viewModel.releaseDate)
                    }
                    .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 20.0, trailing: 8.0))
                }
                .clipped()
                .navigationTitle("Movie Details")
            }
        }
        .onAppear {
            viewModel.getDetails()
        }
    }
}

#Preview {
    MovieDetailsView()
}
