//
//  NetworkProvider.swift
//  CoinCo
//
//  Created by 김도형 on 3/7/25.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

struct NetworkProvider<E: EndPoint>: Sendable {
    func request<T: Decodable>(_ endPoint: E) -> Single<T> {
        return .create { observer in
            let task = Task {
                do {
#if DEBUG
                    try NetworkLogger.request(endPoint)
#endif
                    let response = await AF.request(endPoint)
                        .validate(statusCode: 200..<300)
                        .serializingDecodable(T.self, decoder: endPoint.decoder)
                        .response
#if DEBUG
                    try NetworkLogger.response(response)
#endif
                    switch response.result {
                    case .success(let value):
                        observer(.success(value))
                    case .failure(let error):
                        guard let data = response.data else {
                            throw error
                        }
                        throw endPoint.error(
                            response.response?.statusCode,
                            data: data
                        )
                    }
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create { task.cancel() }
        }
    }
}
