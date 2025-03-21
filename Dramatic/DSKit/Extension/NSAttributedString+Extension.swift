//
//  NSAttributedString+Extension.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

extension NSAttributedString {
    static func dt(
        _ string: String,
        font: DTFont,
        attributes: [NSAttributedString.Key: Any] = [:],
        at matchedString: String...
    ) -> NSAttributedString {
        var attributes = attributes
        attributes.updateValue(font.uiFont, forKey: .font)
        
        let attributedString = NSMutableAttributedString(string: string)
        if matchedString.isEmpty {
            attributedString.addAttributes(
                attributes,
                range: .init(location: 0, length: attributedString.length)
            )
        } else {
            for matched in matchedString {
                var stringRange = string.startIndex..<string.endIndex
                while let range = string.range(of: matched, options: [], range: stringRange) {
                    attributedString.mutableString.range(of: matched)
                    attributedString.addAttributes(attributes, range: NSRange(range, in: string))
                    stringRange = range.upperBound..<string.endIndex
                }
            }
        }
        
        return attributedString
    }
}
