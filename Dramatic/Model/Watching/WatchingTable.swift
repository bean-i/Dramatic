//
//  WatchingTable.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

import RealmSwift

class WatchingTable: Object {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted(indexed: true)
    var seasonId: Int
    
    convenience init(id: Int, seasonId: Int) {
        self.init()
        
        self.id = id
        self.seasonId = seasonId
    }
}
