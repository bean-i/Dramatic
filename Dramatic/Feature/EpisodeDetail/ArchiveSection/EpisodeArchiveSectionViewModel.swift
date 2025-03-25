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
        case registration
    }
    
    enum Mutation {
        case mutatedArchiveTypes(EpisodeArchiveButton.ArchiveType)
        case bindWishTableObservable
        case bindWatchedTableObservable
        case bindWatchingTableObservable
    }
    
    struct State {
        var archiveTypes = Set<EpisodeArchiveButton.ArchiveType>()
        var dramaEntity: DramaEntity
        var season: SeasonResponse
    }
    
    var initialState: State
    
    private let wishTableProvider = RealmProvider<WishTable>()
    private let watchedTableProvider = RealmProvider<WatchedTable>()
    private let watchingTableProvider = RealmProvider<WatchingTable>()
    
    init(dramaEntity: DramaEntity, season: SeasonResponse) {
        self.initialState = .init(
            dramaEntity: dramaEntity,
            season: season
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .wishButtonTapped:
            if let object = wishTableProvider.read(currentState.season.id) {
                try? wishTableProvider.delete(object)
            } else {
                let object = WishTable(
                    id: currentState.season.id,
                    title: currentState.season.name,
                    content: currentState.dramaEntity.content,
                    imageURL: currentState.dramaEntity.imageURL
                )
                try? wishTableProvider.create(object)
            }
            return .empty()
        case .registration:
            return .merge(
                wishTableProvider.observable().map { _ in
                    Mutation.bindWishTableObservable
                },
                watchedTableProvider.observable().map { _ in
                    Mutation.bindWatchedTableObservable
                },
                watchingTableProvider.observable().map { _ in
                    Mutation.bindWatchingTableObservable
                }
            )
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
        case .bindWishTableObservable:
            if wishTableProvider.read(newState.season.id) != nil {
                newState.archiveTypes.insert(.보고싶어요)
            } else {
                newState.archiveTypes.remove(.보고싶어요)
            }
            return newState
        case .bindWatchedTableObservable:
            if watchedTableProvider.read(newState.season.id) != nil {
                newState.archiveTypes.insert(.봤어요)
            } else {
                newState.archiveTypes.remove(.봤어요)
            }
            return newState
        case .bindWatchingTableObservable:
            let object = watchingTableProvider.readAll().first(where: {
                $0.seasonId == newState.season.id
            })
            if object != nil {
                newState.archiveTypes.insert(.보는중)
            } else {
                newState.archiveTypes.remove(.보는중)
            }
            return newState
        }
    }
}
