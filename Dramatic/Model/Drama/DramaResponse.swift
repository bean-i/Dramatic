//
//  DramaDTO.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import Foundation

struct PageDTO: Decodable {
    let page: Int
    let results: [DramaResponse]
}

struct DramaResponse: Decodable, DramaDTO {
    var id: Int
    var title: String
    var imageURL: String?
    var genreIds: [Int]
    var content: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case imageURL = "poster_path"
        case genreIds = "genre_ids"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        content = genreIds.first
            .flatMap { id in GenreDTO.mockData.first { $0.id == id }?.name } ?? ""
    }
}

extension PageDTO {
    static var empty: PageDTO {
        return PageDTO(page: 0, results: [])
    }
}

extension DramaResponse {
    static var mockDramaDTOs: [DramaResponse] {
        return [
//            DramaResponse(id: 123, title: "Severance", imageURL: "/pPHpeI2X1qEd1CS1SeyrdhZ4qnT.jpg", genreIds: [18, 9648, 10765]),
//            DramaResponse(id: 123, title: "Solo Leveling", imageURL: "/geCRueV3ElhRTr0xtJuEWJt6dJ1.jpg", genreIds: [16, 10759, 10765]),
//            DramaResponse(id: 123, title: "The Residence", imageURL: "/vZTkAmho63W5XAfegpcpMA7OXpV.jpg", genreIds: [18, 35, 9648]),
//            DramaResponse(id: 123, title: "When Life Gives You Tangerines", imageURL: "/q29q6AByug53pnylCytwLA7m6AY.jpg", genreIds: [18]),
//            DramaResponse(id: 123, title: "Reacher", imageURL: "/31GlRQMiDunO8cl3NxTz34U64rf.jpg", genreIds: [10759, 80, 18]),
//            DramaResponse(id: 123, title: "Adolescence", imageURL: "/tDHWWReefmOOjBCJZUck8cNwssk.jpg", genreIds: [18, 80]),
//            DramaResponse(id: 123, title: "Dope Thief", imageURL: "/fB0LKIEagglaJcNYzFPkYAEWON.jpg", genreIds: [80, 18]),
//            DramaResponse(id: 123, title: "Wolf King", imageURL: "/jgs2AtxtOMRuVHYjSofbv3P9WnN.jpg", genreIds: [16, 10759, 10762, 10765]),
//            DramaResponse(id: 123, title: "Happy Face", imageURL: "/sGHZrYxOU2U2JLrmYO12qGl1VK4.jpg", genreIds: [18, 80]),
//            DramaResponse(id: 123, title: "Gangs of London", imageURL: "/fVgwa6wGw9ddGM5O7mqrrwB6gHK.jpg", genreIds: [80, 18]),
//            DramaResponse(id: 123, title: "Hyper Knife", imageURL: "/hHkiSxa7O8kPjyyTJ9ue2mqYJVx.jpg", genreIds: [18, 80]),
//            DramaResponse(id: 123, title: "Good American Family", imageURL: "/fzznLJmBzU5tTxFzklepKifE16o.jpg", genreIds: [18]),
//            DramaResponse(id: 123, title: "Daredevil: Born Again", imageURL: "/9lLuhV703HGCbnz6FxnqCwIwzAZ.jpg", genreIds: [18, 80])
        ]
    }
}
