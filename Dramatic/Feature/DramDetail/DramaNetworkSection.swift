//
//  DramaNetworkSection.swift
//  Dramatic
//
//  Created by 김도형 on 3/22/25.
//

import UIKit

import SnapKit

final class DramaNetworkSection: BaseCollectionViewListCell {
    private let vstack = UIStackView()
    
    override func configureView() {
        contentView.backgroundColor = .clear
        configureVStack()
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(vstack)
    }
    
    override func configureLayout() {
        vstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureVStack() {
        vstack.axis = .vertical
        vstack.spacing = 12
        vstack.distribution = .fillEqually
    }
    
    func registration(items: [DramaDetail.Network]) {
        for url in items {
            let cell = DramaNetworkCell(
                url: "https://image.tmdb.org/t/p/original\(url.logoPath)"
            )
            vstack.addArrangedSubview(cell)
        }
    }
}
