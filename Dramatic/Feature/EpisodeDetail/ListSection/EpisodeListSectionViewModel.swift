//
//  EpisodeListSectionViewModel.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

import RxSwift
import ReactorKit

final class EpisodeListSectionViewModel: Reactor {
    enum Action {
        case collectionItemSelected(Int)
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var episodes: [Season.Episode]
    }
    
    var initialState: State
    
    init(episodes: [Season.Episode]) {
        self.initialState = .init(episodes: episodes)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
