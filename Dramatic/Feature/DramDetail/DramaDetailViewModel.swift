//
//  DramaDetailViewModel.swift
//  Dramatic
//
//  Created by 김도형 on 3/23/25.
//

import Foundation

import ReactorKit

final class DramaDetailViewModel: Reactor {
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let id: Int
        var dramaDetail: DramaDetail? = .mock
    }
    
    var initialState: State
    
    init(id: Int) {
        initialState = State(id: id)
    }
}
