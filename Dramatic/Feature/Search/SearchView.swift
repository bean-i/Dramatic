//
//  SearchView.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchBar = DTSearchBar(with: "드라마를 검색해 보세요.")
    
    private let stackView = UIStackView()
    private let popularButton = DTTabButton(title: "인기")
    private let actorButton = DTTabButton(title: "배우 및 제작진")
    private let programButton = DTTabButton(title: "TV 프로그램")
    private let movieButton = DTTabButton(title: "영화")

    let posterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterCollectionView.collectionViewLayout = configureCollectionViewLayout()
    }
    
    override func configureHierarchy() {
        stackView.addArrangedSubviews(
            popularButton,
            actorButton,
            programButton,
            movieButton
        )
        
        addSubViews(
            searchBar,
            stackView,
            posterCollectionView
        )
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(20)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .dt(.primitive(.black))
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        
        posterCollectionView.showsVerticalScrollIndicator = false
        posterCollectionView.showsHorizontalScrollIndicator = false
        posterCollectionView.backgroundColor = .dt(.primitive(.black))
        
        posterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let deviceWidth = frame.width
        let itemSize = floor((deviceWidth - (4 * spacing)) / 3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.itemSize = CGSize(width: itemSize, height: itemSize * 1.5)
        return layout
    }
    
}
