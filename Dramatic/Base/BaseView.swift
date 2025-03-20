//
//  BaseView.swift
//  Dramatic
//
//  Created by 이빈 on 3/20/25.
//

import UIKit

class BaseView: UIView {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() {
        backgroundColor = .black
    }
    
}
