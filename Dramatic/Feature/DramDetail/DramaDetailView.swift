//
//  DramaDetailView.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

import SnapKit

final class DramaDetailView: BaseView {
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    private var dataSource: DataSource?
    
    override func configureView() {
        super.configureView()
        
        collectionView.backgroundColor = .clear
        
        configureDataSource()
    }
    
    override func configureHierarchy() {
        addSubViews(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            switch Section(rawValue: sectionIndex) {
            case .backdrop: self?.configureBackdropSection()
            case .description: self?.configureDescriptionSection()
            case .network:
                self?.configureNetworkSection(environment: environment)
            default: nil
            }
        }
    }
    
    private func configureBackdropSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func configureDescriptionSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    private func configureNetworkSection(
        environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(100)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    private func configureDataSource() {
        let backdropSectionRegistration = UICollectionView.CellRegistration(
            handler: backdropSectionRegistrationHandler
        )
        
        let descriptionSectionRegistration = UICollectionView.CellRegistration(
            handler: descriptionSectionRegistrationHandler
        )
        
        let networkSectionRegistration = UICollectionView.CellRegistration(
            handler: networkSectionRegistrationHandler
        )
        
        dataSource = DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .backdrop(url):
                return collectionView.dequeueConfiguredReusableCell(
                    using: backdropSectionRegistration,
                    for: indexPath,
                    item: url
                )
            case let .description(dramaDetail):
                return collectionView.dequeueConfiguredReusableCell(
                    using: descriptionSectionRegistration,
                    for: indexPath,
                    item: dramaDetail
                )
            case let .network(network):
                return collectionView.dequeueConfiguredReusableCell(
                    using: networkSectionRegistration,
                    for: indexPath,
                    item: network
                )
            }
        }
    }
    
    private func backdropSectionRegistrationHandler(
        cell: DramaBackdropSection,
        indexPath: IndexPath,
        id: String
    ) {
        cell.registration(url: id)
    }
    
    private func descriptionSectionRegistrationHandler(
        cell: DramaDescriptionSection,
        indexPath: IndexPath,
        id: DramaDetail
    ) {
        cell.registration(item: id)
    }
    
    private func networkSectionRegistrationHandler(
        cell: DramaNetworkSection,
        indexPath: IndexPath,
        id: [DramaDetail.Network]
    ) {
        cell.registration(items: id)
        
        let backgroundConfiguration = UIBackgroundConfiguration.clear()
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    func configureSnapShot(item: DramaDetail) {
        var snapShot = SnapShot()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(
            [.backdrop(item.backdropPath)],
            toSection: .backdrop
        )
        snapShot.appendItems(
            [.description(item)],
            toSection: .description
        )
        snapShot.appendItems(
            [.network(item.networks)],
            toSection: .network
        )
        dataSource?.apply(snapShot)
    }
}

extension DramaDetailView {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SectionItem>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, SectionItem>
    
    enum Section: Int, CaseIterable {
        case backdrop
        case description
        case network
    }
    
    enum SectionItem: Hashable {
        case backdrop(String)
        case description(DramaDetail)
        case network([DramaDetail.Network])
    }
}

@available(iOS 17.0, *)
#Preview {
    DramaDetailViewController()
}
