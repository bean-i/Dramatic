//
//  CGColor+Extension.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

extension CGColor {
    static func dt(_ dtColor: DTColor, alpha: CGFloat = 1) -> CGColor {
        return dtColor.uiColor.withAlphaComponent(alpha).cgColor
    }
}
