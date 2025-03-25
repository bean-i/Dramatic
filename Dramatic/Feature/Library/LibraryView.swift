//
//  LibraryView.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import UIKit
import SnapKit

final class LibraryView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let stackView = UIStackView()
    let toWatchArchiveView = DTArchiveStatusView(title: "보고싶어요")
    let watchedArchiveView = DTArchiveStatusView(title: "봤어요")
    let watchingArchiveView = DTArchiveStatusView(title: "보는중", color: .dt(.semantic(.text(.brand))))
    
    private let toWatchHeader = DTHeader(title: "보고싶어요")
    lazy var toWatchCollectionView = DTDramaHorizontalCollectionView(size: size)
    
    let watchedHeader = DTHeader(title: "봤어요")
    lazy var watchedCollectionView = DTDramaHorizontalCollectionView(size: size)
    
    let watchingHeader = DTHeader(title: "보는중")
    lazy var watchingCollectionView = DTDramaHorizontalCollectionView(size: size)
    
    let a = DTHeader(title: "보는중")
    lazy var aCollectionView = DTDramaHorizontalCollectionView(size: size)
    
    private let size = DTDramaHorizontalCollectionView.DTCardType.drama
    
    override func configureHierarchy() {
        stackView.addArrangedSubviews(
            toWatchArchiveView,
            watchedArchiveView,
            watchingArchiveView
        )
        
        contentView.addSubViews(
            stackView,
            toWatchHeader,
            toWatchCollectionView,
            watchedHeader,
            watchedCollectionView,
            watchingHeader,
            watchingCollectionView,
            a,
            aCollectionView
        )
        
        scrollView.addSubview(contentView)
        
        addSubview(scrollView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        toWatchHeader.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
        }

        toWatchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(toWatchHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
        }
        
        watchedHeader.snp.makeConstraints { make in
            make.top.equalTo(toWatchCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
        }

        watchedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(watchedHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
        }
        
        watchingHeader.snp.makeConstraints { make in
            make.top.equalTo(watchedCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
        }

        watchingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(watchingHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
            make.bottom.equalToSuperview().inset(30)
        }
        
    }
    
    override func configureView() {
        backgroundColor = .dt(.semantic(.bg(.primary)))
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }
    
}
