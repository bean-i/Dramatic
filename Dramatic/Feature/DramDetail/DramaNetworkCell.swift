//
//  DramaNetworkCell.swift
//  Dramatic
//
//  Created by 김도형 on 3/22/25.
//

import UIKit

import SnapKit

final class DramaNetworkCell: BaseView {
    private let logoImageView = UIImageView()
    private let chevronImageView = UIImageView()
    
    private let url: String
    
    init(url: String) {
        self.url = url
        
        super.init(frame: .zero)
    }
    
    override func configureView() {
        configureContentView()
        
        configureLogoImageView()
        
        configureChevronImageView()
    }
    
    override func configureHierarchy() {
        addSubViews(
            logoImageView,
            chevronImageView
        )
    }
    
    override func configureLayout() {
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(60)
            make.verticalEdges.leading.equalToSuperview().inset(12)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.verticalEdges.trailing.equalToSuperview().inset(12)
        }
    }
    
    private func configureContentView() {
        backgroundColor = .secondaryLabel
        layer.cornerRadius = 8
    }
    
    private func configureLogoImageView() {
        logoImageView.setImage(with: url)
        logoImageView.contentMode = .scaleAspectFit
    }
    
    private func configureChevronImageView() {
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .dt(.semantic(.icon(.secondary)))
    }
}

@available(iOS 17.0, *)
#Preview {
    DramaDetailViewController()
}
