//
//  EpisodeDetailViewModel.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import Foundation

import ReactorKit

final class EpisodeDetailViewModel: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let dramaName: String
        let season: Season
        var archiveTypes = Set<EpisodeArchiveButton.ArchiveType>()
    }
    
    var initialState: State
    
    init(dramaName: String, season: Season) {
        self.initialState = .init(
            dramaName: dramaName,
            season: season
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
