//
//  UIFont+Extension.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

extension UIFont {
    static func dt(_ dtFont: DTFont) -> UIFont {
        return dtFont.uiFont
    }
}
