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
        case mutatedDramaDetail(DramaDetail)
    }
    
    struct State {
        let id: Int
        var dramaDetail: DramaDetail?
    }
    
    var initialState: State
    
    init(id: Int) {
        initialState = State(id: id)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return TVClient.shared.fetchDetails(id: initialState.id)
                .map { Mutation.mutatedDramaDetail($0) }
                .asObservable()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .mutatedDramaDetail(let dramaDetail):
            newState.dramaDetail = dramaDetail
            return newState
        }
    }
}
