//
//  DramaDetailView.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class DramaDetailView: BaseView {
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    private var dataSource: DataSource?
    private var disposeBag = DisposeBag()
    let episodeSectionModelSelected = PublishSubject<DramaDetailResponse.Season>()
    
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
            case .season: self?.configureEpisodeSection()
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
    
    private func configureEpisodeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(300)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(300)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 0)
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
        
        let episodeSectionRegistration = UICollectionView.CellRegistration(
            handler: episodeSectionRegistrationHandler
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
            case let .season(seasons):
                return collectionView.dequeueConfiguredReusableCell(
                    using: episodeSectionRegistration,
                    for: indexPath,
                    item: seasons
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
        id: DramaDetailResponse
    ) {
        cell.registration(item: id)
    }
    
    private func networkSectionRegistrationHandler(
        cell: DramaNetworkSection,
        indexPath: IndexPath,
        id: [DramaDetailResponse.Network]
    ) {
        cell.registration(items: id)
        
        let backgroundConfiguration = UIBackgroundConfiguration.clear()
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    private func episodeSectionRegistrationHandler(
        cell: DramaEpisodeSection,
        indexPath: IndexPath,
        id: [DramaDetailResponse.Season]
    ) {
        disposeBag = DisposeBag()
        
        cell.collectionView.registration(
            items: id,
            cardType: .episode,
            disposeBag: disposeBag
        )
        cell.collectionView.collectionView.rx.modelSelected(DramaDetailResponse.Season.self)
            .bind(to: episodeSectionModelSelected)
            .disposed(by: disposeBag)
    }
    
    func configureSnapShot(item: DramaDetailResponse) {
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
        snapShot.appendItems(
            [.season(item.seasons)],
            toSection: .season
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
        case season
    }
    
    enum SectionItem: Hashable {
        case backdrop(String)
        case description(DramaDetailResponse)
        case network([DramaDetailResponse.Network])
        case season([DramaDetailResponse.Season])
    }
}

extension Reactive where Base: DramaDetailView {
    var configureSnapShot: Binder<DramaDetailResponse> {
        Binder(base) { base, dramaDetail in
            base.configureSnapShot(item: dramaDetail)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    DramaDetailViewController(viewModel: DramaDetailViewModel(id: 219246))
}
