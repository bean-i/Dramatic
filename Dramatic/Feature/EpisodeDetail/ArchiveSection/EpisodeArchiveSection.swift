//
//  EpisodeArchiveSection.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class EpisodeArchiveButton: UIButton {
    enum ArchiveType: String, CaseIterable {
        case 보고싶어요
        case 봤어요
        case 보는중
        
        var image: UIImage? {
            switch self {
            case .보고싶어요: return .dt(.plusApp)
            case .봤어요: return .dt(.checkmarkSquareFill)
            case .보는중: return .dt(.eyeFill)
            }
        }
    }
    
    let type: ArchiveType
    
    init(type: ArchiveType) {
        self.type = type
        
        super.init(frame: .zero)
        
        configure()
        
        configureUpdateHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tap: Observable<ArchiveType> {
        rx.tap.withUnretained(self)
            .map { this, _ in this.type }
    }
    
    private func configure() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = type.rawValue
        configuration.image = type.image
        configuration.imagePadding = 12
        configuration.imagePlacement = .top
        configuration.baseBackgroundColor = .clear
        self.configuration = configuration
        tintColor = .dt(.semantic(.icon(.secondary)))
    }
    
    private func configureUpdateHandler() {
        configurationUpdateHandler = { button in
            switch button.state {
            case .selected:
                button.tintColor = .dt(.semantic(.icon(.brand)))
            default:
                button.tintColor = .dt(.semantic(.icon(.secondary)))
            }
        }
    }
}

final class EpisodeArchiveSection: BaseCollectionViewCell, View {
    private var buttons = [EpisodeArchiveButton]()
    private let hstack = UIStackView()
    
    var disposeBag = DisposeBag()
    
    override func configureView() {
        contentView.backgroundColor = .clear
        
        configureHStack()
        
        configureButtons()
    }
    
    override func configureHierarchy() {
        contentView.addSubViews(hstack)
    }
    
    override func configureLayout() {
        hstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureHStack() {
        hstack.axis = .horizontal
        hstack.spacing = 8
        hstack.distribution = .fillEqually
    }
    
    private func configureButtons() {
        for type in EpisodeArchiveButton.ArchiveType.allCases {
            let button = EpisodeArchiveButton(type: type)
            buttons.append(button)
            hstack.addArrangedSubview(button)
        }
    }
    
    func bind(reactor: EpisodeArchiveSectionViewModel) {
        for button in buttons {
            if button.type == .보고싶어요 {
                button.tap
                    .map { _ in Reactor.Action.wishButtonTapped }
                    .bind(to: reactor.action)
                    .disposed(by: disposeBag)
            }
            
            reactor.state.map(\.archiveTypes)
                .map { $0.contains(button.type) }
                .bind(to: button.rx.isSelected)
                .disposed(by: disposeBag)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    let section = EpisodeArchiveSection()
    section.reactor = EpisodeArchiveSectionViewModel(
        dramaEntity: DramaEntity.mockEntities[0],
        season: .mock
    )
    
    return section
}
