//
//  DramaDTO.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import Foundation

struct DramaResponseDTO: Decodable {
    let page: Int
    let results: [DramaDTO]
}

struct DramaDTO: Decodable {
    let id: Int
    let title: String
    let imageURL: String?
    let genreIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case imageURL = "poster_path"
        case genreIds = "genre_ids"
    }
}

extension DramaResponseDTO {
    static var empty: DramaResponseDTO {
        return DramaResponseDTO(page: 0, results: [])
    }
}

extension DramaDTO {
    func toEntity() -> DramaEntity {
        let firstGenreName = genreIds.first
            .flatMap { id in GenreDTO.mockData.first { $0.id == id }?.name } ?? ""
        
        return DramaEntity(
            id: id,
            title: title,
            content: firstGenreName,
            imageURL: APIKey.IMAGE_BASE_URL + (imageURL ?? "")
        )
    }
}

extension DramaDTO {
    static var mockDramaDTOs: [DramaDTO] {
        return [
            DramaDTO(id: 123, title: "Severance", imageURL: "/pPHpeI2X1qEd1CS1SeyrdhZ4qnT.jpg", genreIds: [18, 9648, 10765]),
            DramaDTO(id: 123, title: "Solo Leveling", imageURL: "/geCRueV3ElhRTr0xtJuEWJt6dJ1.jpg", genreIds: [16, 10759, 10765]),
            DramaDTO(id: 123, title: "The Residence", imageURL: "/vZTkAmho63W5XAfegpcpMA7OXpV.jpg", genreIds: [18, 35, 9648]),
            DramaDTO(id: 123, title: "When Life Gives You Tangerines", imageURL: "/q29q6AByug53pnylCytwLA7m6AY.jpg", genreIds: [18]),
            DramaDTO(id: 123, title: "Reacher", imageURL: "/31GlRQMiDunO8cl3NxTz34U64rf.jpg", genreIds: [10759, 80, 18]),
            DramaDTO(id: 123, title: "Adolescence", imageURL: "/tDHWWReefmOOjBCJZUck8cNwssk.jpg", genreIds: [18, 80]),
            DramaDTO(id: 123, title: "Dope Thief", imageURL: "/fB0LKIEagglaJcNYzFPkYAEWON.jpg", genreIds: [80, 18]),
            DramaDTO(id: 123, title: "Wolf King", imageURL: "/jgs2AtxtOMRuVHYjSofbv3P9WnN.jpg", genreIds: [16, 10759, 10762, 10765]),
            DramaDTO(id: 123, title: "Happy Face", imageURL: "/sGHZrYxOU2U2JLrmYO12qGl1VK4.jpg", genreIds: [18, 80]),
            DramaDTO(id: 123, title: "Gangs of London", imageURL: "/fVgwa6wGw9ddGM5O7mqrrwB6gHK.jpg", genreIds: [80, 18]),
            DramaDTO(id: 123, title: "Hyper Knife", imageURL: "/hHkiSxa7O8kPjyyTJ9ue2mqYJVx.jpg", genreIds: [18, 80]),
            DramaDTO(id: 123, title: "Good American Family", imageURL: "/fzznLJmBzU5tTxFzklepKifE16o.jpg", genreIds: [18]),
            DramaDTO(id: 123, title: "Daredevil: Born Again", imageURL: "/9lLuhV703HGCbnz6FxnqCwIwzAZ.jpg", genreIds: [18, 80])
        ]
    }
}

// 임시
let genreMap: [Int: String] = [
    10759: "Action & Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    10762: "Kids",
    9648: "Mystery",
    10763: "News",
    10764: "Reality",
    10765: "Sci-Fi & Fantasy",
    10766: "Soap",
    10767: "Talk",
    10768: "War & Politics",
    37: "Western"
]
