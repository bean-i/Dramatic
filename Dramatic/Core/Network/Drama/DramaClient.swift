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

    
    func fetchDrama(router: DramaEndpoint) -> Single<DramaResponseDTO> {
        return provider.request(router)
            .catch { error in
                return Single.just(DramaResponseDTO.empty)
            }
    }
    
    func fetchDramaWithId(router: DramaEndpoint) -> Single<DramaResponseDTO> {
        switch router {
        case .similar(let id):
            return provider.request(.similar(id: id))
        case .recommend(let id):
            return provider.request(.recommend(id: id))
        default:
            return Single.just(DramaResponseDTO.empty)
        }
    }
    
}
