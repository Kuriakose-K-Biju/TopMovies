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
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable, Hashable {
    let name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
}
