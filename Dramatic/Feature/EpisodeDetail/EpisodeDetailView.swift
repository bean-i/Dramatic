//
//  EpisodeDetailView.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class EpisodeDetailView: BaseView {
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    private var dataSource: DataSource?
    private var disposeBag = DisposeBag()
    
    override func configureView() {
        super.configureView()
        
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        
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
            case .info: return self?.configureInfoSection()
            case .archive: return self?.configureArchiveSection()
            case .list: return self?.configureListSection()
            default: return nil
            }
        }
    }
    
    private func configureInfoSection() -> NSCollectionLayoutSection {
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
        section.contentInsets = .init(top: 0, leading: 16, bottom: 20, trailing: 16)
        return section
    }
    
    private func configureArchiveSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 20, trailing: 16)
        return section
    }
    
    private func configureListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(500)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(500)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func configureDataSource() {
        let archiveSectionRegistration = UICollectionView.CellRegistration(
            handler: archiveSectionRegistrationHandler
        )
        
        let infoSectionRegistration = UICollectionView.CellRegistration(
            handler: infoSectionRegistrationHandler
        )
        
        let listSectionRegistration = UICollectionView.CellRegistration(
            handler: listSectionRegistrationHandler
        )
        
        dataSource = DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .info(dramaName, season):
                return collectionView.dequeueConfiguredReusableCell(
                    using: infoSectionRegistration,
                    for: indexPath,
                    item: (dramaName, season)
                )
            case let .archive(drama, season):
                return collectionView.dequeueConfiguredReusableCell(
                    using: archiveSectionRegistration,
                    for: indexPath,
                    item: (drama, season)
                )
            case let .list(season, drama):
                return collectionView.dequeueConfiguredReusableCell(
                    using: listSectionRegistration,
                    for: indexPath,
                    item: (season, drama)
                )
            }
        }
    }
    
    private func archiveSectionRegistrationHandler(
        cell: EpisodeArchiveSection,
        indexPath: IndexPath,
        id: (DramaEntity, Season)
    ) {
        cell.reactor = EpisodeArchiveSectionViewModel(
            dramaEntity: id.0,
            season: id.1
        )
        cell.reactor?.action.onNext(.registration)
    }
    
    private func infoSectionRegistrationHandler(
        cell: EpisodeInfoSection,
        indexPath: IndexPath,
        id: (String, Season)
    ) {
        cell.registration(dramaName: id.0, item: id.1)
    }
    
    private func listSectionRegistrationHandler(
        cell: EpisodeListSection,
        indexPath: IndexPath,
        id: (Season, DramaEntity)
    ) {
        let viewModel = EpisodeListSectionViewModel(
            season: id.0,
            drama: id.1
        )
        cell.reactor = viewModel
    }
    
    func configureSnapShot(drama: DramaEntity, item: Season) {
        var snapShot = SnapShot()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems([.archive(drama, item)], toSection: .archive)
        snapShot.appendItems([.info(drama.title, item)], toSection: .info)
        snapShot.appendItems([.list(item, drama)], toSection: .list)
        dataSource?.apply(snapShot)
    }
}

extension Reactive where Base: EpisodeDetailView {
    var configureSnapShot: Binder<(DramaEntity, Season)> {
        Binder(base) { base, season in
            base.configureSnapShot(
                drama: season.0,
                item: season.1
            )
        }
    }
}

extension EpisodeDetailView {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SectionItem>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, SectionItem>
    
    enum Section: Int, CaseIterable {
        case info
        case archive
        case list
    }
    
    enum SectionItem: Hashable {
        case info(String, Season)
        case archive(DramaEntity, Season)
        case list(Season, DramaEntity)
    }
}

@available(iOS 17.0, *)
#Preview {
    let view = EpisodeDetailView()
    view.configureSnapShot(drama: DramaEntity.mockEntities[0] , item: .mock)
    
    return view
}
