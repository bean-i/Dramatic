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
        let drama: DramaEntity
        let season: SeasonResponse
        var archiveTypes = Set<EpisodeArchiveButton.ArchiveType>()
    }
    
    var initialState: State
    
    init(drama: DramaEntity, season: SeasonResponse) {
        self.initialState = State(
            drama: drama,
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
