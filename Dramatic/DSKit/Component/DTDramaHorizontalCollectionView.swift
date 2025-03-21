//
//  DTDramaHorizontalCollectionView.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import UIKit
import SnapKit

final class DTDramaHorizontalCollectionView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    init(width: Double, height: Double) {
        // 초기화 할 때, 크기 받아와서 지정.
        super.init(frame: .zero)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            <#code#>
        }
    }
    
    override func configureView() {
        collectionView.register(
            DTDramaHorizontalCollectionViewCell.self,
            forCellWithReuseIdentifier: DTDramaHorizontalCollectionViewCell.identifier
        )
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        return layout
    }
    
}

final class DTDramaHorizontalCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "DTDramaHorizontalCollectionViewCell"
    
    private let imageContentView = UIView()
    let imageView = UIImageView()
    
}
