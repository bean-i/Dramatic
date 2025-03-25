//
//  EpisodeTable.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

import RealmSwift

class EpisodeTable: Object {
    @Persisted(primaryKey: true) var id: Int
    
    convenience init(id: Int) {
        self.init()
        
        self.id = id
    }
}
