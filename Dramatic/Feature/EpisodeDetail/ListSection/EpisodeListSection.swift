//
//  EpisodeListSection.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class EpisodeListSection: BaseCollectionViewCell, View {
    private let header = DTHeader(title: "에피소드")
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    typealias DataSource = UICollectionViewDiffableDataSource<String, SeasonResponse.Episode>
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, SeasonResponse.Episode>
    
    private var dataSource: DataSource?
    var disposeBag = DisposeBag()
    
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
        id: SeasonResponse.Episode
    ) {
        cell.registration(item: id)
        
        let backgroundConfiguration = UIBackgroundConfiguration.clear()
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    func bind(reactor: EpisodeListSectionViewModel) {
        collectionView.rx.itemSelected
            .map { Reactor.Action.collectionItemSelected($0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    
        reactor.state.map(\.season.episodes)
            .bind(with: self) { this, episodes in
                var snapshot = Snapshot()
                let section = "Episode"
                snapshot.appendSections([section])
                snapshot.appendItems(episodes, toSection: section)
                this.dataSource?.apply(snapshot)
            }
            .disposed(by: disposeBag)
    }
}

@available(iOS 17.0, *)
#Preview {
    let cell = EpisodeListSection()
    let viewModel = EpisodeListSectionViewModel(season: .mock, drama: DramaEntity.mockEntities[0])
    cell.reactor = viewModel
    cell.contentView.backgroundColor = .black
    return cell
}
