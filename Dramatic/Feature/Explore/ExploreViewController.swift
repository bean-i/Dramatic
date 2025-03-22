//
//  ExploreViewController.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import UIKit

final class ExploreViewController: BaseViewController<ExploreView> {
    
    // 더미 이미지 URL 배열 (예시)
    private let dummyImageURLs: [String] = [
        "https://picsum.photos/seed/1/400/300",
        "https://picsum.photos/seed/2/400/300",
        "https://picsum.photos/seed/3/400/300",
        "https://picsum.photos/seed/4/400/300",
        "https://picsum.photos/seed/5/400/300",
        "https://picsum.photos/seed/1/400/300",
        "https://picsum.photos/seed/2/400/300",
        "https://picsum.photos/seed/3/400/300",
        "https://picsum.photos/seed/4/400/300",
        "https://picsum.photos/seed/5/400/300"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.exploreCollectionView.delegate = self
        mainView.exploreCollectionView.dataSource = self
    }
}

extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dummyImageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ExploreCollectionViewCell.identifier,
            for: indexPath) as? ExploreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let url = dummyImageURLs[indexPath.item]
        cell.configureData(url: url)
        return cell
    }
    
    // 커스텀 스냅핑: 스크롤 종료 시 셀의 중앙이 화면 중앙에 오도록 조정
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = mainView.exploreCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
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
        let numberOfItems = mainView.exploreCollectionView.numberOfItems(inSection: 0)
        index = min(max(index, 0), CGFloat(numberOfItems - 1))
        
        // 선택된 셀의 중앙이 화면 중앙에 오도록 targetContentOffset 계산
        let newOffsetX = index * totalCellWidth + inset + cellWidth / 2 - deviceWidth / 2
        targetContentOffset.pointee = CGPoint(x: newOffsetX, y: targetContentOffset.pointee.y)
    }


}
