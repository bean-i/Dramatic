//
//  WatchedTable.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

import RealmSwift

class WatchedTable: Object, DramaDTO {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var title: String
    @Persisted
    var content: String
    @Persisted
    var imageURL: String?
    
    convenience init(
        id: Int,
        title: String,
        content: String,
        imageURL: String?
    ) {
        self.init()
        
        self.id = id
        self.title = title
        self.content = content
        self.imageURL = imageURL
    }
}
