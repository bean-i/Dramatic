//
//  EpisodeDetailViewController.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa
import RxFlow

final class EpisodeDetailViewController: BaseViewController<EpisodeDetailView>, View, Stepper {
    
    var steps = PublishRelay<Step>()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(reactor: EpisodeDetailViewModel) {
        let drama = reactor.state.map(\.drama)
        let season = reactor.state.map(\.season)
        
        Observable.zip(drama, season)
            .bind(to: mainView.rx.configureSnapShot)
            .disposed(by: disposeBag)
    }
}
