//
//  SearchViewController.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import UIKit
import RxSwift
import ReactorKit

final class SearchViewController: BaseViewController<SearchView> {
    
    var disposeBag = DisposeBag()

    override func configureNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = SearchViewModel()
    }

}

extension SearchViewController: View {
    
    func bind(reactor: SearchViewModel) {
        // 검색
        mainView.searchBar.searchBar.rx.searchButtonClicked
            .withUnretained(self)
            .map { owner, _ in (1, owner.mainView.searchBar.searchBar.text) }
            .map { Reactor.Action.loadSearchData(page: $0.0, keyword: $0.1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // 셀 선택
        mainView.posterCollectionView.rx.modelSelected(DramaDisplayable.self)
            .map { Reactor.Action.selectDrama(id: $0.id) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // 결과 데이터 반영
        reactor.pulse(\.$searchDrama)
            .bind(to: mainView.posterCollectionView.rx.items(cellIdentifier: PosterCollectionViewCell.identifier, cellType: PosterCollectionViewCell.self)) { (row, element, cell) in
                cell.imageView.setImage(with: element.imageURL)
            }
            .disposed(by: disposeBag)
        
        // 셀 선택: 화면 전환
        reactor.state
            .map { $0.selectedDrama }
            .bind(with: self) { owner, id in
                print("화면전환 아이디: \(id)")
            }
            .disposed(by: disposeBag)
    }

}
