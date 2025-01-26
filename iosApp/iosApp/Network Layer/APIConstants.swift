//
//  APIConstants.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

final class APIConstants {
    static var basedURL: String = "https://api.themoviedb.org/3/movie"
    static var apiToken: String = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODEwNWRiZTQwYmVhMTFjNWIwMjQxYTRiZTIxMDUxNSIsIm5iZiI6MTUwODg1ODE3NS41MTcsInN1YiI6IjU5ZWY1OTNmYzNhMzY4NDFjNzAwZWE5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CcjVcHy5TnsyaUnZu4lrBcHQJU1s5cHoPAxdxEkyEQk"
}

enum HTTPHeaderField: String {
    case acceptType = "Accept"
    case authorization = "Authorization"
}

enum ContentType: String {
    case json = "application/json"
}
