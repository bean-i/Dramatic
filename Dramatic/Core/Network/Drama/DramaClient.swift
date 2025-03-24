//
//  DramaClient.swift
//  Dramatic
//
//  Created by 이빈 on 3/23/25.
//

import Foundation
import Alamofire
import RxSwift

final class DramaClient {
    
    static let shared = DramaClient()

    private let provider = NetworkProvider<DramaEndpoint>()

    private init() {}
    
    func fetchTrendingDrama() -> Single<PageDTO> {
        return provider.request(.trending)
            .catch { error in
                return Single.just(PageDTO.empty)
            }
    }
    
    func fetchPopularDrama() -> Single<PageDTO> {
        return provider.request(.popular)
            .catch { error in
                return Single.just(PageDTO.empty)
            }
    }
    
    func fetchRatedDrama() -> Single<PageDTO> {
        return provider.request(.rated)
            .catch { error in
                return Single.just(PageDTO.empty)
            }
    }
    
    func fetchSimilarDrama(id: Int) -> Single<PageDTO> {
        return provider.request(.similar(id: id))
            .catch { error in
                return Single.just(PageDTO.empty)
            }
    }

    func fetchRecommendDrama(id: Int) -> Single<PageDTO> {
        return provider.request(.recommend(id: id))
            .catch { error in
                return Single.just(PageDTO.empty)
            }
    }
    
    func fetchSearchDrama(page: Int, keyword: String?) -> Single<PageDTO> {
        guard let keyword else { return Single.just(PageDTO.empty) }
        
        return provider.request(.search(page: page, keyword: keyword))
            .catch { error in
                return Single.just(PageDTO.empty)
            }
    }
    
}
