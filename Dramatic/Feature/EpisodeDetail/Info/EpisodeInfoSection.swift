//
//  EpisodeInfoSection.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import SnapKit

final class EpisodeInfoSection: BaseCollectionViewCell {
    private let titleLabel = UILabel()
    private let episodeLabel = UILabel()
    private let overviewLabel = UILabel()
    private let imageView = UIImageView()
    
    override func configureView() {
        contentView.backgroundColor = .clear
        
        configureTitleLabel()
        
        configureEpisodeLabel()
        
        configureOverviewLabel()
        
        configureImageView()
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            titleLabel,
            episodeLabel,
            overviewLabel,
            imageView
        )
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(imageView.snp.leading).inset(8)
        }
        
        episodeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalTo(imageView.snp.leading).inset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(160)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel.font = .dt(.largeTitle)
        titleLabel.textColor = .dt(.semantic(.text(.primary)))
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
    }
    
    private func configureEpisodeLabel() {
        episodeLabel.font = .dt(.body)
        episodeLabel.textColor = .dt(.semantic(.text(.secondary)))
        episodeLabel.textAlignment = .left
    }
    
    private func configureOverviewLabel() {
        overviewLabel.font = .dt(.body)
        overviewLabel.textColor = .dt(.semantic(.text(.secondary)))
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .left
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }
    
    func registration(dramaName: String, item: SeasonResponse) {
        titleLabel.text = dramaName + " " + item.name
        episodeLabel.text = "\(item.episodes.count)개의 에피소드"
        overviewLabel.text = item.overview
        imageView.setImage(with: "\(Bundle.main.imageBaseURL("w500"))\(item.posterPath ?? "")")
    }
}

@available(iOS 17.0, *)
#Preview {
    let cell = EpisodeInfoSection()
    cell.contentView.backgroundColor = .black
    cell.registration(dramaName: "폭싹 속았수다", item: SeasonResponse.mock)
    
    return cell
}
