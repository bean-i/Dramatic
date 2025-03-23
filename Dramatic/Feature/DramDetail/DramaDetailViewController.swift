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

final class DramaDetailViewController: BaseViewController<DramaDetailView> {
    private let viewModel: DramaDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: DramaDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindState()
        
        bindAction()
        
        viewModel.action.onNext(.viewDidLoad)
    }
}

private extension DramaDetailViewController {
    typealias Action = DramaDetailViewModel.Action
    
    func bindState() {
        viewModel.state.map(\.dramaDetail)
            .compactMap(\.self)
            .bind(to: mainView.rx.configureSnapShot)
            .disposed(by: disposeBag)
        
        viewModel.pulse(\.$showSeasonDetail)
            .asDriver(onErrorJustReturn: nil)
            .compactMap(\.self)
            .drive(with: self) { this, season in
                /// 임시
                this.navigationController?.pushViewController(UIViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func bindAction() {
        mainView.episodeSectionModelSelected
            .map { Action.episodeSectionModelSelected($0) }
            .bind(to: viewModel.action)
            .disposed(by: disposeBag)
    }
}

@available(iOS 17.0, *)
#Preview {
    DramaDetailViewController(viewModel: DramaDetailViewModel(id: 219246))
}
