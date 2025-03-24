//
//  DramaEpisodeSection.swift
//  Dramatic
//
//  Created by 김도형 on 3/23/25.
//

import UIKit

import SnapKit

final class DramaEpisodeSection: BaseCollectionViewCell {
    private let header = DTHeader(title: "작품정보")
    let collectionView = DTDramaHorizontalCollectionView(size: .episode)
    
    override func configureView() {
        contentView.backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            header,
            collectionView
        )
    }
    
    override func configureLayout() {
        header.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(16)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
}
