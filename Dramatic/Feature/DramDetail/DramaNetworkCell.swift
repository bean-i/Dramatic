//
//  DramaNetworkCell.swift
//  Dramatic
//
//  Created by 김도형 on 3/22/25.
//

import UIKit

import SnapKit

final class DramaNetworkCell: BaseCollectionViewCell {
    private let logoImageView = UIImageView()
    private let chevronImageView = UIImageView()
    
    override func configureView() {
        configureContentView()
        
        configureLogoImageView()
        
        configureChevronImageView()
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            logoImageView,
            chevronImageView
        )
    }
    
    override func configureLayout() {
        logoImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(12)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(12)
        }
    }
    
    private func configureContentView() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
    }
    
    private func configureLogoImageView() {
        logoImageView.contentMode = .scaleAspectFit
    }
    
    private func configureChevronImageView() {
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.contentMode = .scaleAspectFit
    }
    
    func registration(url: String) {
        logoImageView.setImage(with: url)
    }
}
