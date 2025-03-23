//
//  ExploreCollectionViewCell.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import UIKit
import SnapKit

final class ExploreCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "ExploreCollectionViewCell"
    
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
        imageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configureData(url: String) {
        imageView.setImage(with: url)
    }
    
}
