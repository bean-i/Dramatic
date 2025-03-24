//
//  SearchViewModel.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import Foundation
import RxSwift
import ReactorKit

final class SearchViewModel: Reactor {
    
    enum Action {
        case loadSearchData(page: Int, keyword: String?)
        case selectDrama(id: Int)
    }
    
    enum Mutation {
        case setSearchDrama(dramas: [DramaDisplayable])
        case setSelectedDrama(id: Int)
    }
    
    struct State {
        @Pulse var searchDrama: [DramaDisplayable]
        var selectedDrama: Int?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(searchDrama: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadSearchData(let page, let keyword):
            return DramaClient.shared.fetchSearchDrama(page: page, keyword: keyword)
                .map { Mutation.setSearchDrama(dramas: $0.results.map { $0.toEntity() }) }
                .asObservable()
            
        case .selectDrama(let id):
            return Observable.just(Mutation.setSelectedDrama(id: id))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSearchDrama(let dramas): newState.searchDrama = dramas
        case .setSelectedDrama(let id): newState.selectedDrama = id
        }
        return newState
    }
    
}
