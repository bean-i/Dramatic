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
    @Persisted
    var episodes: List<EpisodeTable>
    
    convenience init(
        id: Int,
        title: String,
        content: String,
        imageURL: String?,
        episodes: [EpisodeTable]
    ) {
        self.init()
        
        self.id = id
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.episodes.append(objectsIn: episodes)
    }
}
