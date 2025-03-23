//
//  ExploreView.swift
//  Dramatic
//
//  Created by 이빈 on 3/22/25.
//

import UIKit
import SnapKit

final class ExploreView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let trendingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let popularHeader = DTHeader(title: "실시간 인기 드라마")
    lazy var popularCollectionView = DTDramaHorizontalCollectionView(size: size)
    
    let ratedHeader = DTHeader(title: "평점 높은 드라마")
    lazy var ratedCollectionView = DTDramaHorizontalCollectionView(size: size)
    
    let similarHeader = DTHeader(title: "00와 비슷한 드라마")
    lazy var similarCollectionView = DTDramaHorizontalCollectionView(size: size)
    
    let recommendHeader = DTHeader(title: "추천 작품")
    lazy var recommendCollectionView = DTDramaHorizontalCollectionView(size: size)

    private let size = DTDramaHorizontalCollectionView.DTCardType.drama
    
    
    override func configureHierarchy() {
        
        contentView.addSubViews(
            trendingCollectionView,
            popularHeader,
            popularCollectionView,
            ratedHeader,
            ratedCollectionView,
            similarHeader,
            similarCollectionView,
            recommendHeader,
            recommendCollectionView
        )
        
        scrollView.addSubview(contentView)
        
        addSubview(
            scrollView
        )
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(400)
        }

        popularHeader.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
        }

        popularCollectionView.snp.makeConstraints { make in
            make.top.equalTo(popularHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
        }

        ratedHeader.snp.makeConstraints { make in
            make.top.equalTo(popularCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
        }

        ratedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ratedHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
        }
        
        similarHeader.snp.makeConstraints { make in
            make.top.equalTo(ratedCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
        }

        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
        }
        
        recommendHeader.snp.makeConstraints { make in
            make.top.equalTo(similarCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
        }

        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    override func configureView() {
        scrollView.backgroundColor = .dt(.primitive(.black))
        scrollView.showsVerticalScrollIndicator = false
        
        trendingCollectionView.register(TrendingCollectionViewCell.self,
                                       forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        
        trendingCollectionView.isPagingEnabled = false
        trendingCollectionView.decelerationRate = .fast
        
        trendingCollectionView.backgroundColor = .dt(.primitive(.black))
        trendingCollectionView.showsHorizontalScrollIndicator = false
        trendingCollectionView.showsVerticalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trendingCollectionView.collectionViewLayout = configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = frame.width
        let itemWidth = deviceWidth * 0.8
        let itemHeight: CGFloat = 400
        let horizontalInset = (deviceWidth - itemWidth) / 2
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: horizontalInset,
                                           bottom: 0,
                                           right: horizontalInset)
        return layout
    }
}
