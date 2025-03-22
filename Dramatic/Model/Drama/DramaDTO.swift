//
//  DramaDTO.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import Foundation

struct DramaDTO: Decodable, DramaDisplayable {
    let title: String
    let content: String
    let imageURL: String
}
