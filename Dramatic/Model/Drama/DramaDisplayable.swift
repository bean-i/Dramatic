//
//  DramaDisplayable.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import Foundation

protocol DramaDisplayable {
    var id: Int { get }
    var title: String { get }
    var content: String { get }
    var imageURL: String? { get }
}
