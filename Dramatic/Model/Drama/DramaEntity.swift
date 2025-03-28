//
//  DramaEntity.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import Foundation

struct DramaEntity: DramaDisplayable, Hashable {
    let id: Int
    let title: String
    let content: String
    let imageURL: String?
}

extension DramaEntity {
    static var mockEntities: [DramaEntity] {
        DramaResponse.mockDramaDTOs.map { $0.toEntity() }
    }
}
