//
//  LibraryViewController.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import UIKit
import RxSwift
import ReactorKit

final class LibraryViewController: BaseViewController<LibraryView> {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = LibraryViewModel()
    }
    
    override func configureNavigation() {
        let title = UILabel()
        title.text = "보관함"
        title.textColor = .dt(.semantic(.text(.primary)))
        title.font = .dt(.largeTitle)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: title)
    }

}

extension LibraryViewController: View {

    func bind(reactor: LibraryViewModel) {
        // 저장한 드라마
        reactor.pulse(\.$toWatchDrama)
            .bind(to: mainView.toWatchCollectionView.collectionView.rx.items(cellIdentifier: DTDramaHorizontalCollectionViewCell.identifier, cellType: DTDramaHorizontalCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(drama: element, cardType: DTDramaHorizontalCollectionView.DTCardType.drama)
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$watchedDrama)
            .bind(to: mainView.watchedCollectionView.collectionView.rx.items(cellIdentifier: DTDramaHorizontalCollectionViewCell.identifier, cellType: DTDramaHorizontalCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(drama: element, cardType: DTDramaHorizontalCollectionView.DTCardType.drama)
            }
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$watchingDrama)
            .bind(to: mainView.watchingCollectionView.collectionView.rx.items(cellIdentifier: DTDramaHorizontalCollectionViewCell.identifier, cellType: DTDramaHorizontalCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(drama: element, cardType: DTDramaHorizontalCollectionView.DTCardType.drama)
            }
            .disposed(by: disposeBag)
        
        // 저장한 드라마 개수
        reactor.state
            .map { "\($0.toWatchCount)" }
            .bind(to: mainView.toWatchArchiveView.countLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { "\($0.watchedCount)" }
            .bind(to: mainView.watchedArchiveView.countLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { "\($0.watchingCount)" }
            .bind(to: mainView.watchingArchiveView.countLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 셀 선택
        Observable.merge(
            mainView.watchedCollectionView.collectionView.rx.modelddSelected(DramaDisplayable.self).asObservable(),
            mainView.toWatchCollectionView.collectionView.rx.modelSelected(DramaDisplayable.self).asObservable(),
            mainView.watchingCollectionView.collectionView.rx.modelSelected(DramaDisplayable.self).asObservable()
        )
        .map { Reactor.Action.selectDrama(id: $0.id) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        // 화면 전환
        reactor.state
            .map { $0.selectedDrama }
            .bind(with: self) { owner, id in
                print("화면전환 아이디: \(id)")
            }
            .disposed(by: disposeBag)
    }
    
}
