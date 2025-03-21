//
//  UIView+Extension.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
