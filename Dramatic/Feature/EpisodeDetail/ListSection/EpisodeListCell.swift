//
//  EpisodeListCell.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import SnapKit
import RealmSwift
import RxSwift
import RxCocoa

final class EpisodeListCell: BaseCollectionViewCell {
    private let stillImageView = UIImageView()
    private let numberLabel = UILabel()
    private let runtimeLabel = UILabel()
    private let airDateLabel = UILabel()
    private let overviewLabel = UILabel()
    private let watchedImageView = UIImageView()
    
    private let watchingTableProvider = RealmProvider<WatchingTable>()
    private var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stillImageView.image = nil
        watchedImageView.isHidden = true
        
        disposeBag = DisposeBag()
    }
    
    override func configureView() {
        contentView.backgroundColor = .clear
        
        configureStillImageView()
        
        configureNumberLabel()
        
        configureRuntimeLabel()
        
        configureAirDateLabel()
        
        configureOverviewLabel()
        
        configureWatchedImageView()
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            stillImageView,
            numberLabel,
            runtimeLabel,
            airDateLabel,
            overviewLabel,
            watchedImageView
        )
    }
    
    override func configureLayout() {
        stillImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(100)
        }
        
        watchedImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(36)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(stillImageView)
            make.leading.equalTo(stillImageView.snp.trailing).offset(12)
            make.trailing.equalTo(watchedImageView.snp.leading).inset(12)
            
        }
        
        runtimeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(8)
            make.leading.equalTo(stillImageView.snp.trailing).offset(12)
            make.trailing.equalTo(watchedImageView.snp.leading).inset(12)
        }
        
        airDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stillImageView)
            make.leading.equalTo(stillImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(stillImageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    private func configureStillImageView() {
        stillImageView.contentMode = .scaleAspectFill
        stillImageView.layer.cornerRadius = 8
        stillImageView.clipsToBounds = true
    }
    
    private func configureNumberLabel() {
        numberLabel.font = .dt(.headline)
        numberLabel.textColor = .dt(.semantic(.text(.primary)))
        numberLabel.textAlignment = .left
    }
    
    private func configureRuntimeLabel() {
        runtimeLabel.font = .dt(.body)
        runtimeLabel.textColor = .dt(.semantic(.text(.secondary)))
        runtimeLabel.textAlignment = .left
    }
    
    private func configureAirDateLabel() {
        airDateLabel.font = .dt(.body)
        airDateLabel.textColor = .dt(.semantic(.text(.secondary)))
        airDateLabel.textAlignment = .left
    }
    
    private func configureOverviewLabel() {
        overviewLabel.font = .dt(.body)
        overviewLabel.textColor = .dt(.semantic(.text(.secondary)))
        overviewLabel.numberOfLines = 0
        overviewLabel.textAlignment = .left
    }
    
    private func configureWatchedImageView() {
        watchedImageView.image = .dt(.checkmarkSquareFill)
        watchedImageView.tintColor = .dt(.semantic(.icon(.secondary)))
    }
    
    func registration(item: SeasonResponse.Episode) {
        if let stillPath = item.stillPath {
            stillImageView.setImage(
                with: "\(Bundle.main.imageBaseURL("w500"))\(stillPath)"
            )
            
            watchedImageView.isHidden = false
        }
        numberLabel.text = "\(item.episodeNumber)화"
        
        if let runtime = item.runtime {
            let hour = runtime / 60
            let minute = runtime % 60
            runtimeLabel.text = hour == 0
            ? "\(minute)분"
            : "\(hour)시간 \(minute)분"
        }
        
        let date = item.airDate?.toDate(.airDate)
        airDateLabel.text = date?.toString(.episodeAirDate)
        
        overviewLabel.text = item.overview
        
        let isContain = watchingTableProvider.read(item.id) != nil
        watchedImageView.tintColor = isContain
        ? .dt(.semantic(.icon(.brand)))
        : .dt(.semantic(.icon(.secondary)))
        
        watchingTableProvider.observable()
            .withUnretained(self)
            .map { this, _ in
                let isContain = this.watchingTableProvider.read(item.id) != nil
                return isContain
            }
            .bind(with: self) { this, isContain in
                this.watchedImageView.tintColor = isContain
                ? .dt(.semantic(.icon(.brand)))
                : .dt(.semantic(.icon(.secondary)))
            }
            .disposed(by: disposeBag)
    }
}

@available(iOS 17.0, *)
#Preview {
    let cell = EpisodeListCell()
    cell.contentView.backgroundColor = .black
    cell.registration(item: SeasonResponse.mock.episodes[0])
    
    return cell
}
