//
//  MockupGenerator.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import Foundation

struct MockupGenerator {
    static func generate<T: Decodable>(_ jsonString: String) -> T? {
        guard let result = jsonString.data(using: .utf8) else {
            return nil
        }
        do {
            let data = try JSONDecoder().decode(T.self, from: result)
            return data
        } catch {
            print(error)
            return nil
        }
    }
}
