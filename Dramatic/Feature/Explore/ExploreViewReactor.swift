//
//  ExploreViewReactor.swift
//  Dramatic
//
//  Created by 이빈 on 3/23/25.
//

import Foundation
import RxSwift
import ReactorKit

final class ExploreViewReactor: Reactor {
    
    // 인풋
    enum Action {
        case loadData
        case loadSimilarData(id: Int)
        case loadRecommendData(id: Int)
    }
    
    // 중간 과정?: API 통신 결과 반영
    enum Mutation {
        case setTrendingDrama(dramas: [DramaEntity])
        case setPopularDrama(dramas: [DramaEntity])
        case setRatedDrama(dramas: [DramaEntity])
        case setSimilarDrama(dramas: [DramaEntity])
        case setRecommendDrama(dramas: [DramaEntity])
        case setSimilarDramaTitle(title: String)
    }
    
    // 상태: 표시할 데이터
    struct State {
        var trendingDrama: [DramaEntity] = []
        var popularDrama: [DramaEntity] = []
        var ratedDrama: [DramaEntity] = []
        var similarDrama: [DramaEntity] = []
        var recommendDrama: [DramaEntity] = []
        var similarDramaTitle: String = ""
    }
    
    let initialState = State()
    
    // 액션 발생 마다 실행됨
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            // 5개의 API 통신 실행
            return Observable.concat(
                [
                    Observable.just(Mutation.setTrendingDrama(dramas: DramaEntity.mockEntities)),
                    Observable.just(Mutation.setPopularDrama(dramas: DramaEntity.mockEntities)),
                    Observable.just(Mutation.setRatedDrama(dramas: DramaEntity.mockEntities))
                ]
            )
        case .loadSimilarData: // id기반 통신 + 타이틀 보여주기
            return Observable.just(Mutation.setSimilarDrama(dramas: DramaEntity.mockEntities))
        case .loadRecommendData: // id기반 통신
            return Observable.just(Mutation.setRecommendDrama(dramas: DramaEntity.mockEntities))
        }
    }
    
    // Mutation 발생 마다 실행됨
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setTrendingDrama(let dramas):
            newState.trendingDrama = dramas
        case .setPopularDrama(let dramas):
            newState.popularDrama = dramas
        case .setRatedDrama(let dramas):
            newState.ratedDrama = dramas
        case .setSimilarDrama(let dramas):
            newState.similarDrama = dramas
        case .setRecommendDrama(let dramas):
            newState.recommendDrama = dramas
        case .setSimilarDramaTitle(let title):
            newState.similarDramaTitle = title
        }
        return newState
    }
    
    
}
