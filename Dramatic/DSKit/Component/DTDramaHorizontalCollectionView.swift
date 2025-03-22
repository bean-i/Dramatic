//
//  DTDramaHorizontalCollectionView.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import UIKit
import SnapKit

struct Drama {
    let title: String
    let content: String
    let imageURL: String
}

// MARK: - DTCardType
enum DTCardType {
    case drama
    case episode
    
    var imageWidth: CGFloat {
        switch self {
        case .drama: return 140
        case .episode: return 150
        }
    }
    
    var imageHeight: CGFloat {
        switch self {
        case .drama: return 100
        case .episode: return 200
        }
    }
    
    var titleHeight: CGFloat {
        return 50
    }
    
    var offset: CGFloat {
        switch self {
        case .drama: return 5
        case .episode: return 2
        }
    }
    
    var totalHeight: CGFloat {
        return imageHeight + titleHeight + offset
    }
}

// MARK: - DTDramaHorizontalCollectionView
final class DTDramaHorizontalCollectionView: BaseView {
    
    private let size: DTCardType
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    init(size: DTCardType) {
        self.size = size
        super.init(frame: .zero)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(size.totalHeight)
        }
    }
    
    override func configureView() {
        collectionView.register(
            DTDramaHorizontalCollectionViewCell.self,
            forCellWithReuseIdentifier: DTDramaHorizontalCollectionViewCell.identifier
        )
        
        collectionView.collectionViewLayout = configureCollectionViewLayout(width: size.imageWidth, height: size.totalHeight)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    private func configureCollectionViewLayout(width: Double, height: Double) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }
    
}

// MARK: - DTDramaHorizontalCollectionViewCell
final class DTDramaHorizontalCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "DTDramaHorizontalCollectionViewCell"
    
    private var type: DTCardType = .drama

    private let imageContentView = UIView()
    private let imageView = UIImageView()
    private let titleView = DTCellTitle(title: "", content: "")
    
    override func configureHierarchy() {
        imageContentView.addSubview(imageView)
        
        contentView.addSubViews(
            imageContentView,
            titleView
        )
    }

    override func configureLayout() {
        imageContentView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(type.imageHeight)
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleView.snp.makeConstraints { make in
            make.top.equalTo(imageContentView.snp.bottom).offset(type.offset)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(type.titleHeight)
        }
    }

    override func configureView() {
        imageContentView.clipsToBounds = true
        imageContentView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
    }

    func configure(drama: Drama, cardType: DTCardType) {
        type = cardType
        titleView.setTitle(drama.title, content: drama.content)
        imageView.setImage(with: drama.imageURL)
        
        updateLayout()
    }
    
    private func updateLayout() {
        imageContentView.snp.remakeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(type.imageHeight)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(imageContentView.snp.bottom).offset(type.offset)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(type.titleHeight)
        }
    }
}
