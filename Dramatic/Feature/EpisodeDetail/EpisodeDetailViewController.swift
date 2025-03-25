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

final class EpisodeDetailViewController: BaseViewController<EpisodeDetailView>, View {
    var reactor: EpisodeDetailViewModel?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.configureSnapShot(dramaName: "폭싹 속았수다", item: .mock)
    }
    
    func bind(reactor: EpisodeDetailViewModel) {
        let dramaName = reactor.state.map(\.dramaName)
        let season = reactor.state.map(\.season)
        
        Observable.zip(dramaName, season)
            .bind(to: mainView.rx.configureSnapShot)
            .disposed(by: disposeBag)
    }
}
