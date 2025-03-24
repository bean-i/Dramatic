//
//  BaseCollectionViewListCell.swift
//  Dramatic
//
//  Created by 김도형 on 3/22/25.
//

import UIKit

class BaseCollectionViewListCell: UICollectionViewListCell {
    
    override init(frame: CGRect) {
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
    
    func configureView() { }
    
}
