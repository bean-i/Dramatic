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
    
    var baseURL: URL? {
        URL(string: Bundle.main.baseURL)
    }
    
    var path: String {
        switch self {
        case let .details(id, _):
            "/tv/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .details:
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
        case .details: return .urlEncodedForm
        }
    }
    
    var parameters: (any Encodable)? {
        switch self {
        case let .details(_, model):
            return model
        }
    }
    
    func error(_ statusCode: Int?, data: Data) -> any Error {
        /// 임시
        AFError.explicitlyCancelled
    }
}
