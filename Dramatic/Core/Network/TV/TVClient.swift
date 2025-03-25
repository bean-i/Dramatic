//
//  TVClient.swift
//  Dramatic
//
//  Created by 김도형 on 3/23/25.
//

import Foundation

import Alamofire
import RxSwift

final class TVClient {
    static let shared = TVClient()
    
    private let provider = NetworkProvider<TVEndPoint>()
    
    private init() {}
    
    func fetchDetails(id: Int) -> Single<DramaDetailResponse> {
        let request = DramaDetailRequest()
        return provider.request(.details(id: id, model: request))
    }
    
    func fetchSeason(seriesId: Int, seasonNumber: Int) -> Single<SeasonResponse> {
        let request = SeasonRequest()
        return provider.request(
            .season(seriesId: seriesId, seasonNumber: seasonNumber, model: request)
        )
    }
}
