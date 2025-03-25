//
//  LibraryViewModel.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import Foundation
import RxSwift
import ReactorKit

final class LibraryViewModel: Reactor {
    
    enum Action {
        case loadArchiveData
        case loadArchiveCountData
        case selectDrama(id: Int)
    }
    
    enum Mutation {
        case setToWatchDrama(dramas: [DramaDisplayable])
        case setWatchedDrama(dramas: [DramaDisplayable])
        case setWatchingDrama(dramas: [DramaDisplayable])
        case setToWatchCount(count: Int)
        case setWatchedCount(count: Int)
        case setWatchingCount(count: Int)
        case setSelectedDrama(id: Int)
    }
    
    struct State {
        @Pulse var toWatchDrama: [DramaDisplayable]
        @Pulse var watchedDrama: [DramaDisplayable]
        @Pulse var watchingDrama: [DramaDisplayable]
        var toWatchCount: Int
        var watchedCount: Int
        var watchingCount: Int
        var selectedDrama: Int?
    }
    
    let initialState: State
    let wishTable = RealmProvider<WishTable>()
    let watchedTable = RealmProvider<WatchedTable>()
    let watchingTable = RealmProvider<WatchingTable>()
    
    init() {
        self.initialState = State(
            toWatchDrama: [],
            watchedDrama: [],
            watchingDrama: [],
            toWatchCount: 0,
            watchedCount: 0,
            watchingCount: 0
        )
        self.action.onNext(.loadArchiveData)
        self.action.onNext(.loadArchiveCountData)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        let wishList = wishTable.readAll().map { $0.toEntity() }
        let watchedList = watchedTable.readAll().map { $0.toEntity() }
        let watchingList = watchingTable.readAll().map { $0.toEntity() }
        
        switch action {
        case .loadArchiveData:
            return Observable.merge(
                Observable.just(Mutation.setToWatchDrama(dramas: Array(wishList))),
                Observable.just(Mutation.setWatchedDrama(dramas: Array(watchedList))),
                Observable.just(Mutation.setWatchingDrama(dramas: Array(watchingList)))
            )
            
        case .loadArchiveCountData:
            return Observable.merge(
                Observable.just(Mutation.setToWatchCount(count: wishList.count)),
                Observable.just(Mutation.setWatchedCount(count: watchedList.count)),
                Observable.just(Mutation.setWatchingCount(count: watchingList.count))
            )
            
        case .selectDrama(let id):
            return Observable.just(Mutation.setSelectedDrama(id: id))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setToWatchDrama(let dramas): newState.toWatchDrama = dramas
        case .setWatchedDrama(let dramas): newState.watchedDrama = dramas
        case .setWatchingDrama(let dramas): newState.watchingDrama = dramas
        case .setSelectedDrama(let id): newState.selectedDrama = id
        case .setToWatchCount(let count): newState.toWatchCount = count
        case .setWatchedCount(let count): newState.watchedCount = count
        case .setWatchingCount(let count): newState.watchingCount = count
        }
        return newState
    }
    
}
