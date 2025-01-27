//
//  MovieDetailsView.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @ObservedObject private var viewModel: MovieViewModel
    
    init(movieID: String) {
        self.viewModel = MovieViewModel(movieID: movieID)
    }
    
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
                        title
                        DetailContentView(title: "Synopsis", value: movieDetails.overview ?? "No Data Available")
                        DetailContentView(title: "User Rating", value: viewModel.movieRating)
                        CastView(castContent: viewModel.castDetails)
                        DetailContentView(title: "Production Company", value: viewModel.productionCompany)
                        DetailContentView(title: "Release Date", value: viewModel.releaseDate)
                    }
                    .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 20.0, trailing: 8.0))
                }
                .clipped()
            }
        }
        .onAppear {
            viewModel.getDetails()
        }
    }
    
    var title: some View {
        return Text(viewModel.movieDetails?.title ?? "No Data Available")
            .font(.title)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
}

#Preview {
    MovieDetailsView(movieID: "273")
}
