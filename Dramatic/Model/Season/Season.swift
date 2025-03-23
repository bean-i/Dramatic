//
//  Season.swift
//  Dramatic
//
//  Created by 김도형 on 3/23/25.
//

import Foundation

struct Season: Decodable, Equatable {
    let name: String
    let overview: String
    let posterPath: String
    let episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case name
        case overview
        case posterPath = "poster_path"
        case episodes
    }
}

extension Season {
    struct Episode: Decodable, Hashable {
        let id: Int
        let episodeNumber: Int
        let airDate: String
        let runtime: Int?
        let stillPath: String?
        let overview: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case episodeNumber = "episode_number"
            case airDate = "air_date"
            case runtime
            case stillPath = "still_path"
            case overview
        }
    }
}
