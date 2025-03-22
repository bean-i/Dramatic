//
//  ExploreView.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import UIKit
import SnapKit

final class ExploreView: BaseView {
    
    let exploreCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func configureHierarchy() {
        addSubview(exploreCollectionView)
    }
    
    override func configureLayout() {
        exploreCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
    override func configureView() {
        exploreCollectionView.register(ExploreCollectionViewCell.self,
                                       forCellWithReuseIdentifier: ExploreCollectionViewCell.identifier)
        
        exploreCollectionView.isPagingEnabled = false
        exploreCollectionView.decelerationRate = .fast
        
        exploreCollectionView.backgroundColor = .clear
        exploreCollectionView.showsHorizontalScrollIndicator = false
        exploreCollectionView.showsVerticalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        exploreCollectionView.collectionViewLayout = configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = frame.width
        let itemWidth = deviceWidth * 0.8
        let itemHeight = exploreCollectionView.frame.height
        let horizontalInset = (deviceWidth - itemWidth) / 2
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: horizontalInset,
                                           bottom: 0,
                                           right: horizontalInset)
        return layout
    }
}
