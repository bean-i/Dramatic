//
//  EpisodeListSectionViewModel.swift
//  Dramatic
//
//  Created by 김도형 on 3/25/25.
//

import Foundation

import RealmSwift
import RxSwift
import ReactorKit

final class EpisodeListSectionViewModel: Reactor {
    enum Action {
        case collectionItemSelected(Int)
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var season: SeasonResponse
        var drama: DramaEntity
    }
    
    var initialState: State
    
    private let watchingTableProvider = RealmProvider<WatchingTable>()
    private let watchedTableProvider = RealmProvider<WatchedTable>()
    private let episodeTableProvider = RealmProvider<EpisodeTable>()
    
    init(season: SeasonResponse, drama: DramaEntity) {
        self.initialState = State(season: season, drama: drama)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .collectionItemSelected(index):
            let episode = currentState.season.episodes[index]
            guard episode.stillPath != nil else { return .empty() }
            
            let object = watchingTableProvider.read(currentState.season.id)
            
            if let object {
                if let episodeIndex = object.episodes.firstIndex(where: { $0.id == episode.id }) {
                    try? watchingTableProvider.write {
                        object.episodes.remove(at: episodeIndex)
                    }
                    if object.episodes.isEmpty {
                        if let episodeObject = episodeTableProvider.read(episode.id) {
                            try? episodeTableProvider.delete(episodeObject)
                        }
                        try? watchingTableProvider.delete(object)
                    }
                } else {
                    let newObject = EpisodeTable(id: episode.id)
                    try? watchedTableProvider.write {
                        object.episodes.append(newObject)
                    }
                }
            } else {
                let newObject = WatchingTable(
                    id: currentState.season.id,
                    title: currentState.season.name,
                    content: currentState.drama.content,
                    imageURL: currentState.drama.imageURL,
                    episodes: [EpisodeTable(id: episode.id)]
                )
                try? watchingTableProvider.create(newObject)
            }
            guard !currentState.season.episodes.isEmpty else {
                return .empty()
            }
            let objects = watchingTableProvider.read(currentState.season.id)
            guard let objects else { return .empty() }
            print(objects)
            let episodes = currentState.season.episodes
            let watchedObject = watchedTableProvider.read(currentState.season.id)
            
            if episodes.count == objects.episodes.count && watchedObject == nil {
                let newObject = WatchedTable(
                    id: currentState.season.id,
                    title: currentState.season.name,
                    content: currentState.drama.title,
                    imageURL: currentState.drama.imageURL
                )
                try? watchedTableProvider.create(newObject)
            } else if let watchedObject {
                try? watchedTableProvider.delete(watchedObject)
            }
            
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
