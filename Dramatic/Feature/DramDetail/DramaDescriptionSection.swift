//
//  DramaDescriptionCell.swift
//  Dramatic
//
//  Created by 김도형 on 3/22/25.
//

import UIKit

import SnapKit

final class DramaDescriptionSection: BaseCollectionViewCell {
    private let titleLabel = UILabel()
    private let infoLabel = UILabel()
    private let overviewLabel = UILabel()
    
    override func configureView() {
        contentView.backgroundColor = .clear
        
        configureTitleLabel()
        
        configureInfoLabel()
        
        configureOverviewLabel()
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            titleLabel,
            infoLabel,
            overviewLabel
        )
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel.font = .dt(.largeTitle)
        titleLabel.textColor = .dt(.semantic(.text(.primary)))
        titleLabel.textAlignment = .left
    }
    
    private func configureInfoLabel() {
        infoLabel.font = .dt(.body)
        infoLabel.textColor = .dt(.semantic(.text(.secondary)))
        infoLabel.textAlignment = .left
    }
    
    private func configureOverviewLabel() {
        overviewLabel.font = .dt(.body)
        overviewLabel.textColor = .dt(.semantic(.text(.secondary)))
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .left
    }
    
    func registration(item: DramaDetail) {
        titleLabel.text = item.name
        let seasonText = "사즌 \(item.numberOfSeasons)개"
        let statusText = item.inProduction ? "방영 중" : "방영 종료"
        let genresText = item.genres.map { $0.name }.joined(separator: " • ")
        infoLabel.text = "\(seasonText) • \(statusText) • \(genresText)"
        overviewLabel.text = item.overview
    }
}
