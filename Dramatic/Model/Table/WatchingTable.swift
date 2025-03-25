//
//  WatchingTable.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

import RealmSwift

class WatchingTable: Object, DramaDTO {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var title: String
    @Persisted
    var content: String
    @Persisted
    var imageURL: String?
    @Persisted(indexed: true)
    var seasonId: Int
    
    convenience init(
        id: Int,
        seasonId: Int,
        title: String,
        content: String,
        imageURL: String?
    ) {
        self.init()
        
        self.id = id
        self.seasonId = seasonId
        self.title = title
        self.content = content
        self.imageURL = imageURL
    }
}
