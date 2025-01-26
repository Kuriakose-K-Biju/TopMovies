//
//  MovieDetailRequest.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

struct GetMovieDetails: Request {
    var jsonDecoder: JSONDecoder?
    typealias ReturnType = MovieModel
    var path: String = ""
    var method: HTTPMethod = .get
    init(movieId: String) {
        self.path = "/\(movieId)"
        let decorder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decorder.dateDecodingStrategy = .formatted(formatter)
        self.jsonDecoder = decorder
    }
}

struct GetCastDetails: Request {
    typealias ReturnType = CastModel
    var path: String = ""
    var method: HTTPMethod = .get
    var queryParams: [String : Any]?
    init(movieId: String, queryParams: [String : Any]) {
        self.path = "/\(movieId)/credits"
        self.queryParams = queryParams
    }
}
