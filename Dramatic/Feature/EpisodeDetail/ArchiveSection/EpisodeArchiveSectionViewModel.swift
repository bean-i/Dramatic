//
//  EpisodeArchiveViewModel.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

import ReactorKit

final class EpisodeArchiveSectionViewModel: Reactor {
    enum Action {
        case wishButtonTapped
    }
    
    enum Mutation {
        case mutatedArchiveTypes(EpisodeArchiveButton.ArchiveType)
    }
    
    struct State {
        var archiveTypes = Set<EpisodeArchiveButton.ArchiveType>()
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .wishButtonTapped:
            return .just(.mutatedArchiveTypes(.보고싶어요))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .mutatedArchiveTypes(archiveType):
            if newState.archiveTypes.contains(archiveType) {
                newState.archiveTypes.remove(archiveType)
            } else {
                newState.archiveTypes.insert(archiveType)
            }
            return newState
        }
    }
}
