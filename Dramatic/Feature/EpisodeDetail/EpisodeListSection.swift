//
//  EpisodeListSection.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class EpisodeListSection: BaseCollectionViewCell {
    private let header = DTHeader(title: "에피소드")
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    typealias DataSource = UICollectionViewDiffableDataSource<String, Season.Episode>
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, Season.Episode>
    
    private var dataSource: DataSource?
    
    override func configureView() {
        contentView.backgroundColor = .clear
        
        configureDataSource()
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(
            header,
            collectionView
        )
    }
    
    override func configureLayout() {
        header.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, environment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.showsSeparators = false
            configuration.backgroundColor = .clear
            
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: environment
            )
            section.contentInsets = .init(top: 12, leading: 16, bottom: 0, trailing: 16)
            section.interGroupSpacing = 16
            return section
        }
    }
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration(
            handler: registrationHandler
        )
        
        dataSource = DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
    private func registrationHandler(
        cell: EpisodeListCell,
        indexPath: IndexPath,
        id: Season.Episode
    ) {
        cell.registration(item: id)
        
        let backgroundConfiguration = UIBackgroundConfiguration.clear()
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    func registration(items: [Season.Episode]) {
        var snapshot = Snapshot()
        let section = "Episode"
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource?.apply(snapshot)
    }
}

@available(iOS 17.0, *)
#Preview {
    let cell = EpisodeListSection()
    cell.registration(items: Season.mock.episodes)
    cell.contentView.backgroundColor = .black
    return cell
}
