//
//  UIStackView+Extension.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
}
