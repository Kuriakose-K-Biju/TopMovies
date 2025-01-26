//
//  MovieViewModel.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    
    @Published var movieDetails: MovieModel? = nil
    @Published var castDetails: CastModel? = nil
    @Published var loaderEnabled: Bool = false
    @Published var networkError: NetworkError? = nil
    var cancelable: Set<AnyCancellable> = []
    
    func getDetails() {
        self.loaderEnabled = true
        guard let movieFetched = MovieDataHandler().get(byIdentifier: 273) else {
            self.getMovieDetailsFromApi()
            return
        }
        self.loaderEnabled = false
        self.movieDetails = movieFetched.convertToMovie()
        self.castDetails = movieFetched.convertToCast()
    }
    
    func getMovieDetailsFromApi() {
        let getMovieApiCall = ApiHandler.callApi(GetMovieDetails(movieId: "273"))
        let getCastApiCall = ApiHandler.callApi(GetCastDetails(movieId: "273", queryParams: ["language": "en-US"]))
        Publishers.Zip(getMovieApiCall, getCastApiCall)
            .sink { [weak self] completion in
                self?.loaderEnabled = false
                switch completion {
                case .finished:
                    self?.networkError = nil
                case .failure(let error):
                    self?.networkError = error
                }
            } receiveValue: { [weak self] movie, casts in
                MovieDataHandler().create(movieRecord: movie, castRecord: casts)
                self?.movieDetails = movie
                self?.castDetails = casts
            }.store(in: &cancelable)
    }
    
    var releaseDate: String {
        if let releaseDate = movieDetails?.releaseDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            return formatter.string(from: releaseDate)
        }
        return "No Data Available"
    }
    
    var productionCompany: String {
        if let prodCompany = movieDetails?.productionCompanies, !prodCompany.isEmpty {
            return prodCompany.map({$0.name ?? ""}).joined(separator: "\n")
        }
        return "No Data Available"
    }
    
    var movieRating: String {
        if let rating = movieDetails?.voteAverage {
            return String(format: "⭐️ %.1f", rating)
        }
        return "No Data Available"
    }
    
    var movieImageURL: String {
        if let imageUrl = movieDetails?.posterPath {
            return "https://image.tmdb.org/t/p/w500".appending(imageUrl)
        }
        return ""
    }
}
