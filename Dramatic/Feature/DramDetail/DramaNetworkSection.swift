//
//  DramaNetworkSection.swift
//  Dramatic
//
//  Created by 김도형 on 3/22/25.
//

import UIKit

import SnapKit

final class DramaNetworkSection: BaseCollectionViewListCell {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: listLayout()
    )
    
    var dataSource: DataSource?
    
    override func configureView() {
        contentView.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func cellRegistrationHandler(
        cell: DramaNetworkCell,
        indexPath: IndexPath,
        id: String
    ) {
        cell.registration(url: id)
        
        var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
        backgroundConfiguration.backgroundColor = .secondarySystemGroupedBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(
            handler: cellRegistrationHandler
        )
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
    func registration(items: [DramaDetail.Network]) {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(items.map { "https://image.tmdb.org/t/p/original\($0.logoPath)" })
        
        dataSource?.apply(snapshot)
    }
}
