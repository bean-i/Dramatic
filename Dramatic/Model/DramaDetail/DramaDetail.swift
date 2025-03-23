//
//  DramaDetail.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import Foundation

struct DramaDetail: Decodable, Hashable {
    let id: Int
    let name: String
    let backdropPath: String
    let genres: [Genre]
    let networks: [Network]
    let numberOfSeasons: Int
    let overview: String
    let inProduction: Bool
    let seasons: [Season]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backdropPath = "backdrop_path"
        case genres
        case networks
        case numberOfSeasons = "number_of_seasons"
        case overview
        case inProduction = "in_production"
        case seasons
    }
}

extension DramaDetail {
    struct Genre: Decodable, Hashable {
        let id: Int
        let name: String
    }
    
    struct Network: Decodable, Hashable {
        let id: Int
        let logoPath: String
        let name: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case logoPath = "logo_path"
            case name
        }
    }
    
    struct Season: Decodable, Hashable, DramaDisplayable {
        let content: String
        let episodeCount: Int
        let id: Int
        let title: String
        let imageURL: String
        let seasonNumber: Int
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.episodeCount = try container.decode(Int.self, forKey: .episodeCount)
            self.id = try container.decode(Int.self, forKey: .id)
            self.seasonNumber = try container.decode(Int.self, forKey: .seasonNumber)
            let url = try container.decode(String.self, forKey: .imageURL)
            self.imageURL = "https://image.tmdb.org/t/p/w500\(url)"
            self.title = try container.decode(String.self, forKey: .title)
            self.content = "\(self.episodeCount)개의 에피소드"
        }
        
        enum CodingKeys: String, CodingKey {
            case episodeCount = "episode_count"
            case id
            case title = "name"
            case imageURL = "poster_path"
            case seasonNumber = "season_number"
        }
    }
}

extension DramaDetail {
    static var mock: DramaDetail? {
        return MockupGenerator.generate("""
        {
            "adult": false,
            "backdrop_path": "/5yk3QwnQxzwKfhU1tlDkV2PSIBz.jpg",
            "created_by": [
                {
                    "id": 2039962,
                    "credit_id": "67cb73e305adfb9eb95b8f44",
                    "name": "임상춘",
                    "original_name": "임상춘",
                    "gender": 1,
                    "profile_path": null
                },
                {
                    "id": 1702876,
                    "credit_id": "67cb7404f8e1f1bc90f587ac",
                    "name": "김원석",
                    "original_name": "김원석",
                    "gender": 2,
                    "profile_path": "/gi27yJkwabyd12P1ogR8Rwefalg.jpg"
                }
            ],
            "episode_run_time": [],
            "first_air_date": "2025-03-07",
            "genres": [
                {
                    "id": 18,
                    "name": "드라마"
                }
            ],
            "homepage": "https://www.netflix.com/title/81681535",
            "id": 219246,
            "in_production": true,
            "languages": [
                "ko"
            ],
            "last_air_date": "2025-03-14",
            "last_episode_to_air": {
                "id": 5853448,
                "name": "변하느니 달이요, 마음이야 늙겠는가",
                "overview": "하고 싶은 것도 많고 되고 싶은 것도 많은 금명. 드디어 일본에서 유학할 기회를 얻는다. 어쩌면 애순과 관식도 오랫동안 바라왔던 꿈을 하나 이룰 수 있을 것 같다.",
                "vote_average": 10,
                "vote_count": 1,
                "air_date": "2025-03-14",
                "episode_number": 8,
                "episode_type": "standard",
                "production_code": "",
                "runtime": 63,
                "season_number": 1,
                "show_id": 219246,
                "still_path": "/hFPydfoHeMswbNTC79ajfWkKa7G.jpg"
            },
            "name": "폭싹 속았수다",
            "next_episode_to_air": {
                "id": 5853449,
                "name": "에피소드 9",
                "overview": "",
                "vote_average": 10,
                "vote_count": 1,
                "air_date": "2025-03-21",
                "episode_number": 9,
                "episode_type": "standard",
                "production_code": "",
                "runtime": null,
                "season_number": 1,
                "show_id": 219246,
                "still_path": null
            },
            "networks": [
                {
                    "id": 213,
                    "logo_path": "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
                    "name": "Netflix",
                    "origin_country": ""
                },
                {
                    "id": 212,
                    "logo_path": "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
                    "name": "Netflix",
                    "origin_country": ""
                }
            ],
            "number_of_episodes": 16,
            "number_of_seasons": 1,
            "origin_country": [
                "KR"
            ],
            "original_language": "ko",
            "original_name": "폭싹 속았수다",
            "overview": "당차고 야무진 소녀와 우직하고 헌신적인 소년. 제주 바닷가 작은 마을에서 한 뼘씩 자라온 두 사람의 인생은 어디로 향할까. 넘어지고 좌절해도 다시 일어서며, 세월을 뛰어넘어 피어나는 사랑 이야기.ㄹㅇ너린어ㅣㅏ러ㅣㅏㄴ어리ㅏ너ㅣ러ㅣㅏㅇ너리ㅏㅓㄴ이ㅏ러ㅣㅏㅇ너리ㅏㄴ어ㅣㅏ러나ㅣㅓ라ㅣㅓㄴ이ㅏㅓ리ㅏㅇ너리ㅏㅓㅇ니ㅏ러ㅣㅏㅇ너리ㅏㅇ너ㅣㅏ러ㅣㅇ나ㅓ라ㅣㅇ너ㅣㅏ렁니ㅏㅓ리ㅏㅇ너리ㅏㄴ어ㅣㅏ렁니ㅏㅓ리아너리ㅏㄴ어ㅣㅏㄹㅇ너ㅣㅏ러ㅏㅣㅇ너ㅣㅏㄹㄴ어ㅏㅣ러이ㅏ너라ㅣㅇ너ㅣㅏ렁니ㅏㅓ리ㅏㅇ너리ㅏㅇ너ㅣㅏ렁니ㅏㅣㅇㄹㄴ",
            "popularity": 19.475,
            "poster_path": "/ihN3sIsoyMLUs7HCKP4BYqAeyrA.jpg",
            "production_companies": [
                {
                    "id": 10675,
                    "logo_path": "/4g8trWzgZLMZTjzRzJbt56DUg4E.png",
                    "name": "Pan Entertainment",
                    "origin_country": "KR"
                },
                {
                    "id": 140692,
                    "logo_path": "/blHOMOg29qc8GmSaiOWYNsxe0vC.png",
                    "name": "Baram Pictures",
                    "origin_country": "KR"
                }
            ],
            "production_countries": [
                {
                    "iso_3166_1": "KR",
                    "name": "South Korea"
                }
            ],
            "seasons": [
                {
                    "air_date": "2025-03-07",
                    "episode_count": 16,
                    "id": 326400,
                    "name": "리미티드 시리즈",
                    "overview": "",
                    "poster_path": "/752qpqTFHrGlZoA5v1viSXsnk3w.jpg",
                    "season_number": 1,
                    "vote_average": 9.9
                }
            ],
            "spoken_languages": [
                {
                    "english_name": "Korean",
                    "iso_639_1": "ko",
                    "name": "한국어/조선말"
                }
            ],
            "status": "Returning Series",
            "tagline": "여전히 꽃잎 같고, 여전히 꿈을 꾸는 당신에게",
            "type": "Scripted",
            "vote_average": 9.139,
            "vote_count": 36
        }
        """)
    }
}
