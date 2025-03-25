//
//  DramaDetailViewController.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxFlow

final class DramaDetailViewController: BaseViewController<DramaDetailView>, View, Stepper {
    
    var steps = PublishRelay<Step>()
    
    var disposeBag = DisposeBag()
    
    init(viewModel: DramaDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reactor?.action.onNext(.viewDidLoad)
    }
    
    func bind(reactor: DramaDetailViewModel) {
        mainView.episodeSectionModelSelected
            .map { Reactor.Action.episodeSectionModelSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map(\.dramaDetail)
            .compactMap(\.self)
            .bind(to: mainView.rx.configureSnapShot)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$showSeasonDetail)
            .asDriver(onErrorJustReturn: nil)
            .compactMap(\.self)
            .drive(with: self) { this, season in
                this.steps.accept(DramaDetailStep.seasonDetail(info: season))
            }
            .disposed(by: disposeBag)
    }
}

@available(iOS 17.0, *)
#Preview {
    DramaDetailViewController(viewModel: DramaDetailViewModel(id: 219246))
}
