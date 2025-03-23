//
//  ExploreViewController.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class ExploreViewController: BaseViewController<ExploreView> {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.trendingCollectionView.delegate = self
        self.reactor = ExploreViewReactor()
    }
    
}

extension ExploreViewController: View {
    
    func bind(reactor: ExploreViewReactor) {
        reactor.action.onNext(.loadData)
        reactor.action.onNext(.loadSimilarData(id: 123))
        reactor.action.onNext(.loadRecommendData(id: 123)) // 사용자가 저장한 데이터 중 랜덤 아이디 뽑아서
        
        reactor.state
            .map { $0.trendingDrama }
            .bind(to: mainView.trendingCollectionView.rx.items(cellIdentifier: TrendingCollectionViewCell.identifier, cellType: TrendingCollectionViewCell.self)) { (row, element, cell) in
                cell.imageView.setImage(with: element.imageURL)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.popularDrama }
            .bind(to: mainView.popularCollectionView.collectionView.rx.items(cellIdentifier: DTDramaHorizontalCollectionViewCell.identifier, cellType: DTDramaHorizontalCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(drama: element, cardType: DTDramaHorizontalCollectionView.DTCardType.drama)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.ratedDrama }
            .bind(to: mainView.ratedCollectionView.collectionView.rx.items(cellIdentifier: DTDramaHorizontalCollectionViewCell.identifier, cellType: DTDramaHorizontalCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(drama: element, cardType: DTDramaHorizontalCollectionView.DTCardType.drama)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.similarDrama }
            .bind(to: mainView.similarCollectionView.collectionView.rx.items(cellIdentifier: DTDramaHorizontalCollectionViewCell.identifier, cellType: DTDramaHorizontalCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(drama: element, cardType: DTDramaHorizontalCollectionView.DTCardType.drama)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.recommendDrama }
            .bind(to: mainView.recommendCollectionView.collectionView.rx.items(cellIdentifier: DTDramaHorizontalCollectionViewCell.identifier, cellType: DTDramaHorizontalCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(drama: element, cardType: DTDramaHorizontalCollectionView.DTCardType.drama)
            }
            .disposed(by: disposeBag)
    }
    
}

extension ExploreViewController: UICollectionViewDelegate {
    
    // 커스텀 스냅핑: 스크롤 종료 시 셀의 중앙이 화면 중앙에 오도록 조정
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = mainView.trendingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        // 셀 크기, 간격, 그리고 좌측 인셋 값
        let cellWidth = layout.itemSize.width
        let spacing = layout.minimumLineSpacing
        let totalCellWidth = cellWidth + spacing
        let inset = layout.sectionInset.left
        let deviceWidth = scrollView.bounds.width

        // 현재 컬렉션뷰 중앙의 위치 (contentOffset + deviceWidth/2)
        let currentCenter = scrollView.contentOffset.x + deviceWidth / 2

        // 현재 중앙 위치로부터 셀의 인덱스 계산 (sectionInset을 빼고, 총 셀 폭으로 나눔)
        var index = (currentCenter - inset) / totalCellWidth

        // 스와이프 속도에 따라 인덱스를 조정하여, 한 셀씩 이동하게 함
        if velocity.x > 0.3 {
            index = floor(index) + 1
        } else if velocity.x < -0.3 {
            index = ceil(index) - 1
        } else {
            index = round(index)
        }
        
        // 인덱스 범위 보정 (0 이상, 최대 아이템 수 - 1)
        let numberOfItems = mainView.trendingCollectionView.numberOfItems(inSection: 0)
        index = min(max(index, 0), CGFloat(numberOfItems - 1))
        
        // 선택된 셀의 중앙이 화면 중앙에 오도록 targetContentOffset 계산
        let newOffsetX = index * totalCellWidth + inset + cellWidth / 2 - deviceWidth / 2
        targetContentOffset.pointee = CGPoint(x: newOffsetX, y: targetContentOffset.pointee.y)
    }

}
