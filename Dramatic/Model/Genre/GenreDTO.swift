//
//  GenreDTO.swift
//  Dramatic
//
//  Created by 이빈 on 3/23/25.
//

import Foundation

struct GenreResponseDTO: Decodable {
    let genres: [GenreDTO]
}

struct GenreDTO: Decodable {
    let id: Int
    let name: String
}

extension GenreDTO {
    func toEntity() -> GenreEntity {
        return GenreEntity(
            name: GenreDTO.mockData.first { $0.id == id }?.name ?? ""
        )
    }
}

extension GenreDTO {
    static var mockData: [GenreDTO] {
        return [
            GenreDTO(id: 10759, name: "Action & Adventure"),
            GenreDTO(id: 16, name: "애니메이션"),
            GenreDTO(id: 35, name: "코미디"),
            GenreDTO(id: 80, name: "범죄"),
            GenreDTO(id: 99, name: "다큐멘터리"),
            GenreDTO(id: 18, name: "드라마"),
            GenreDTO(id: 10751, name: "가족"),
            GenreDTO(id: 10762, name: "Kids"),
            GenreDTO(id: 9648, name: "미스터리"),
            GenreDTO(id: 10763, name: "News"),
            GenreDTO(id: 10764, name: "Reality"),
            GenreDTO(id: 10765, name: "Sci-Fi & Fantasy"),
            GenreDTO(id: 10766, name: "Soap"),
            GenreDTO(id: 10767, name: "Talk"),
            GenreDTO(id: 10768, name: "War & Politics"),
            GenreDTO(id: 37, name: "서부")
        ]
    }
}
