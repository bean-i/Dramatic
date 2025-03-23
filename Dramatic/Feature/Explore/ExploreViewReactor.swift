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
        case selectDrama(id: Int)
    }
    
    // 중간 과정?: API 통신 결과 반영
    enum Mutation {
        case setTrendingDrama(dramas: [DramaEntity])
        case setPopularDrama(dramas: [DramaEntity])
        case setRatedDrama(dramas: [DramaEntity])
        case setSimilarDrama(dramas: [DramaEntity])
        case setRecommendDrama(dramas: [DramaEntity])
        case setSimilarDramaTitle(title: String)
        case setSelectedDrama(id: Int)
    }
    
    // 상태: 표시할 데이터
    struct State {
        var trendingDrama: [DramaEntity]
        var popularDrama: [DramaEntity]
        var ratedDrama: [DramaEntity]
        var similarDrama: [DramaEntity]
        var recommendDrama: [DramaEntity]
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
            let trendingRequest = network.request(.trending)
                .map { (dramas: DramaResponseDTO) -> Mutation in
                        .setTrendingDrama(dramas: dramas.results.map { $0.toEntity() })
                }
                .catch { error in
                    return Single.just(Mutation.setTrendingDrama(dramas: []))
                }
                .asObservable()
            
            let popularRequest = network.request(.popular)
                .map { (dramas: DramaResponseDTO) -> Mutation in
                        .setPopularDrama(dramas: dramas.results.map { $0.toEntity() })
                }
                .catch { error in
                    return Single.just(Mutation.setPopularDrama(dramas: []))
                }
                .asObservable()
            
            let ratedRequest = network.request(.rated)
                .map { (dramas: DramaResponseDTO) -> Mutation in
                        .setRatedDrama(dramas: dramas.results.map { $0.toEntity() })
                }
                .catch { error in
                    return Single.just(Mutation.setRatedDrama(dramas: []))
                }
                .asObservable()

            return Observable.concat([trendingRequest, popularRequest, ratedRequest])
            
        case .loadSimilarData(let id): // id기반 통신 + 타이틀 보여주기
            return network.request(.similar(id: id))
                .map { (dramas: DramaResponseDTO) -> Mutation in
                        .setSimilarDrama(dramas: dramas.results.map { $0.toEntity() })
                }
                .catch { error in
                    return Single.just(Mutation.setSimilarDrama(dramas: []))
                }
                .asObservable()
            
        case .loadRecommendData(let id): // id기반 통신
            return network.request(.recommend(id: id))
                .map { (dramas: DramaResponseDTO) -> Mutation in
                        .setRecommendDrama(dramas: dramas.results.map { $0.toEntity() })
                }
                .catch { error in
                    return Single.just(Mutation.setRecommendDrama(dramas: []))
                }
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
