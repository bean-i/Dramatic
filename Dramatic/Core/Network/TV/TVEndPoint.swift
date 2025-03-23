//
//  TVEndPoint.swift
//  Dramatic
//
//  Created by 김도형 on 3/23/25.
//

import Foundation

import Alamofire

enum TVEndPoint: EndPoint {
    case details(id: Int, model: DramaDetailRequest)
    case season(seriesId: Int, seasonNumber: Int, model: SeasonRequest)
    
    var baseURL: URL? {
        URL(string: Bundle.main.baseURL)
    }
    
    var path: String {
        switch self {
        case let .details(id, _):
            "/tv/\(id)"
        case let .season(seriesId, seasonNumber, _):
            "/tv/\(seriesId)/season/\(seasonNumber)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .details,
             .season:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        ["Authorization": "Bearer " + Bundle.main.accessToken]
    }
    
    var decoder: JSONDecoder {
        JSONDecoder()
    }
    
    var encoder: (any ParameterEncoder)? {
        switch self {
        case .details,
             .season:
            return .urlEncodedForm
        }
    }
    
    var parameters: (any Encodable)? {
        switch self {
        case let .details(_, model):
            return model
        case let .season(_, _, model):
            return model
        }
    }
    
    func error(_ statusCode: Int?, data: Data) -> any Error {
        /// 임시
        AFError.explicitlyCancelled
    }
}
