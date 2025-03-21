//
//  ImageClient.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import Foundation

import Alamofire
import RxSwift

final class ImageClient {
    
    static let shared = ImageClient()
    
    private let session: Session
    
    private let memoryCapacity = 10 * 1024 * 1024 // ram에 저장 가능한 최대 크기
    private let diskCapacity = 100 * 1024 * 1024 // 디스크에 저장 가능한 최대 크기
    
    private init() {
        let urlCache = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: "imageCache" // 디스크에 저장될 경로
        )
        
        let config = URLSessionConfiguration.default
        config.urlCache = urlCache
        config.requestCachePolicy = .returnCacheDataElseLoad // 캐시 된 데이터가 있으면 사용
        
        session = Session(configuration: config)
    }
    
    func requestImage(with url: URL, handler: @escaping (Result<Data, AFError>) -> Void) {
        
        let request = URLRequest(url: url)
        
        if let cached = URLCache.shared.cachedResponse(for: request) {
            handler(.success(cached.data))
            return
        }
        
        let task = session.request(url)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
}
