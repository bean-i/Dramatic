//
//  Bundle+Extension.swift
//  Dramatic
//
//  Created by 김도형 on 3/23/25.
//

import Foundation

extension Bundle {
    var accessToken: String {
        return infoDictionary?["ACCESS_TOKEN"] as? String ?? ""
    }
    
    var baseURL: String {
        return infoDictionary?["BASE_URL"] as? String ?? ""
    }
    
    func imageBaseURL(_ size: String) -> String {
        return (infoDictionary?["IMAGE_BASE_URL"] as? String ?? "") + size
    }
}
