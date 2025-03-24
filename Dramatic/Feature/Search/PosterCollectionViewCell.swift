//
//  PosterCollectionViewCell.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import UIKit
import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    let imageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .dt(.primitive(.gray))
    }
    
}
