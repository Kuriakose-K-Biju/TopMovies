//
//  CastModel.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

// MARK: - Cast Details
struct CastModel: Codable {
    let cast: [Cast]
}

struct Cast: Codable, Hashable {
    let id: Int
    let name: String?
    let profilePath: String?
    var profileUrl: String {
        if let imageEndPoint = profilePath {
            return "https://image.tmdb.org/t/p/w500".appending(imageEndPoint)
        }
        return ""
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePath = "profile_path"
    }
}
