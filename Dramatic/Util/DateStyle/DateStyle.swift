//
//  DateStyle.swift
//  CoinCo
//
//  Created by 김도형 on 3/9/25.
//

import Foundation

enum DateStyle: String, CaseIterable {
    case airDate = "yyyy-MM-dd"
    case episodeAirDate = "yyyy. MM. dd 방영"
    
    static var cachedFormatter: [DateStyle: DateFormatter] {
        var formatters = [DateStyle: DateFormatter]()
        for style in Self.allCases {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = style.rawValue
            formatters[style] = formatter
        }
        return formatters
    }
}

extension Date {
    func toString(_ style: DateStyle) -> String {
        guard let formatter = DateStyle.cachedFormatter[style] else {
            return ""
        }
        return formatter.string(from: self)
    }
}

extension String {
    func toDate(_ style: DateStyle) -> Date? {
        guard let formatter = DateStyle.cachedFormatter[style] else {
            return nil
        }
        return formatter.date(from: self)
    }
}
