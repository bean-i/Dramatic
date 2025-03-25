//
//  TableDTO.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

protocol DramaDTO {
    var id: Int { get set }
    var title: String { get set }
    var content: String { get set }
    var imageURL: String? { get set }
    func toEntity() -> DramaEntity
}

extension DramaDTO {
    func toEntity() -> DramaEntity {
        return DramaEntity(
            id: id,
            title: title,
            content: content,
            imageURL: Bundle.main.imageBaseURL("w500") + (imageURL ?? "")
        )
    }
}
