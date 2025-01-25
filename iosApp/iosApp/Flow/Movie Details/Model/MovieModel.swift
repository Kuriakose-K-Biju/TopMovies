//
//  MovieModel.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

// MARK: - Movie Details
struct MovieModel: Codable {
    let id: Int
    let overview, posterPath: String
    let productionCompanies: [ProductionCompany]
    let releaseDate: Date
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, overview
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let name: String
}
