//
//  DramaBackdropCell.swift
//  Dramatic
//
//  Created by 김도형 on 3/22/25.
//

import UIKit

import SnapKit

final class DramaBackdropSection: BaseCollectionViewCell {
    private let backdropImageView = UIImageView()
    
    override func configureView() {
        contentView.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backdropImageView)
    }
    
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    func registration(url: String) {
        backdropImageView.setImage(with: "https://image.tmdb.org/t/p/w500\(url)")
    }
}
