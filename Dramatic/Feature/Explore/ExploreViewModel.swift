//
//  ExploreViewModel.swift
//  Dramatic
//
//  Created by 이빈 on 3/23/25.
//

import Foundation
import RxSwift
import ReactorKit

final class ExploreViewModel: Reactor {
    
    // 인풋
    enum Action {
        case loadData
        case loadSimilarData(id: Int)
        case loadRecommendData(id: Int)
        case selectDrama(id: Int)
    }
    
    // 중간 과정?: API 통신 결과 반영
    enum Mutation {
        case setTrendingDrama(dramas: [DramaDisplayable])
        case setPopularDrama(dramas: [DramaDisplayable])
        case setRatedDrama(dramas: [DramaDisplayable])
        case setSimilarDrama(dramas: [DramaDisplayable])
        case setRecommendDrama(dramas: [DramaDisplayable])
        case setSimilarDramaTitle(title: String)
        case setSelectedDrama(id: Int)
    }
    
    // 상태: 표시할 데이터
    struct State {
        @Pulse var trendingDrama: [DramaDisplayable]
        @Pulse var popularDrama: [DramaDisplayable]
        @Pulse var ratedDrama: [DramaDisplayable]
        @Pulse var similarDrama: [DramaDisplayable]
        @Pulse var recommendDrama: [DramaDisplayable]
        var similarDramaTitle: String = ""
        var selectedDrama: Int?
    }
    
    let initialState: State
    private let network: NetworkProvider<DramaEndpoint>
    
    init() {
        self.initialState = State(
            trendingDrama: [],
            popularDrama: [],
            ratedDrama: [],
            similarDrama: [],
            recommendDrama: []
        )
        self.network = NetworkProvider()
        self.action.onNext(.loadData)
        self.action.onNext(.loadSimilarData(id: 249042))
        self.action.onNext(.loadRecommendData(id: 127532))
    }
    
    // 액션 발생 마다 실행됨
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            
            let trendingRequest = DramaClient.shared.fetchTrendingDrama()
                .map { Mutation.setTrendingDrama(dramas: $0.results.map { $0.toEntity() }) }
                .asObservable()
            
            let popularRequest = DramaClient.shared.fetchPopularDrama()
                .map { Mutation.setPopularDrama(dramas: $0.results.map { $0.toEntity() }) }
                .asObservable()
            
            let ratedRequest = DramaClient.shared.fetchRatedDrama()
                .map { Mutation.setRatedDrama(dramas: $0.results.map { $0.toEntity() }) }
                .asObservable()

            return Observable.merge([trendingRequest, popularRequest, ratedRequest])
            
        case .loadSimilarData(let id): // id기반 통신 + 타이틀 보여주기
            return DramaClient.shared.fetchSimilarDrama(id: id)
                .map { Mutation.setSimilarDrama(dramas: $0.results.map { $0.toEntity() }) }
                .asObservable()
            
        case .loadRecommendData(let id): // id기반 통신
            return DramaClient.shared.fetchRecommendDrama(id: id)
                .map { Mutation.setRecommendDrama(dramas: $0.results.map { $0.toEntity() }) }
                .asObservable()
            
        case .selectDrama(id: let id):
            return Observable.just(Mutation.setSelectedDrama(id: id))
        }
    }
    
    // Mutation 발생 마다 실행됨
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setTrendingDrama(let dramas): newState.trendingDrama = dramas
        case .setPopularDrama(let dramas): newState.popularDrama = dramas
        case .setRatedDrama(let dramas): newState.ratedDrama = dramas
        case .setSimilarDrama(let dramas): newState.similarDrama = dramas
        case .setRecommendDrama(let dramas): newState.recommendDrama = dramas
        case .setSimilarDramaTitle(let title): newState.similarDramaTitle = title
        case .setSelectedDrama(let id): newState.selectedDrama = id
        }
        return newState
    }
    
}
