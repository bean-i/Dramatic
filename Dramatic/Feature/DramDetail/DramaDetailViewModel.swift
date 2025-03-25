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
        case episodeSectionModelSelected(DramaDetailResponse.Season)
    }
    
    enum Mutation {
        case mutatedDramaDetail(DramaDetailResponse)
        case mutatedSeason(SeasonResponse?)
    }
    
    struct State {
        let id: Int
        var dramaDetail: DramaDetailResponse?
        @Pulse
        var showSeasonDetail: SeasonResponse?
    }
    
    var initialState: State
    
    init(id: Int) {
        initialState = State(id: id)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return TVClient.shared.fetchDetails(id: currentState.id)
                .map { Mutation.mutatedDramaDetail($0) }
                .asObservable()
        case let .episodeSectionModelSelected(season):
            guard let dramaDetail = currentState.dramaDetail else {
                return .empty()
            }
            return TVClient.shared.fetchSeason(
                seriesId: dramaDetail.id,
                seasonNumber: season.seasonNumber
            )
            .catch { error in
                print(error)
                return .error(error)
            }
            .map { Mutation.mutatedSeason($0) }
            .asObservable()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .mutatedDramaDetail(dramaDetail):
            newState.dramaDetail = dramaDetail
            return newState
        case let .mutatedSeason(season):
            newState.showSeasonDetail = season
            return newState
        }
    }
}
