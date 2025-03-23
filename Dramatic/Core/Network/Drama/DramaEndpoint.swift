//
//  DramaEndpoint.swift
//  Dramatic
//
//  Created by 이빈 on 3/23/25.
//

import Foundation
import Alamofire

enum DramaEndpoint: EndPoint {

    case trending
    case popular
    case rated
    case similar(id: Int)
    case recommend(id: Int)
    
    
    var baseURL: URL? { return URL(string: APIKey.BASE_URL) }
    
    var path: String {
        switch self {
        case .trending:
            return "/trending/tv/day"
        case .popular:
            return "/tv/popular"
        case .rated:
            return "/tv/top_rated"
        case .similar(let id):
            return "/tv/\(id)/similar"
        case .recommend(let id):
            return "/tv/\(id)/recommendations"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization": "Bearer \(APIKey.ACCESS_TOKEN)"
        ]
    }
    
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    var encoder: ParameterEncoder? {
        nil
    }
    
    var parameters: Encodable? {
        switch self {
        case .trending:
            return RequestParameters(language: "ko")
        case .popular:
            return RequestParameters(language: "ko")
        case .rated:
            return RequestParameters(language: "ko")
        case .similar:
            return RequestParameters(language: "ko")
        case .recommend:
            return RequestParameters(language: "ko")
        }
    }
    
    func error(_ statusCode: Int?, data: Data) -> any Error {
        return AFError.invalidURL(url: "")
    }
    
    
}
struct RequestParameters: Encodable {
    let language: String
}
