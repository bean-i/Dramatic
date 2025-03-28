//
//  DramaDetailFlow.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import UIKit
import RxFlow

final class DramaDetailFlow: Flow {
    
    var root: Presentable {
        return self.rootNavigationController
    }
    
    private let rootNavigationController: UINavigationController
    
    init() {
        self.rootNavigationController = UINavigationController()
        self.rootNavigationController.navigationBar.tintColor = .dt(.semantic(.icon(.secondary)))
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DramaDetailStep else { return .none }
        switch step {
        case .initialScreen(let id):
            return navigateToDramaDetailScreen(id: id)
        case .seasonDetail(let detail, let info):
            return navigateToSeasonDetailScreen(detail: detail, info: info)
        }
    }
    
    private func navigateToDramaDetailScreen(id: Int) -> FlowContributors {
        let viewController = DramaDetailViewController(viewModel: DramaDetailViewModel(id: id))
        self.rootNavigationController.pushViewController(viewController, animated: false)
        self.rootNavigationController.setNavigationBarHidden(false, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController))
    }
    
    private func navigateToSeasonDetailScreen(detail: DramaDetailResponse, info: SeasonResponse) -> FlowContributors {
        let viewController = EpisodeDetailViewController()
        let dramaEntity = DramaEntity(
            id: detail.id,
            title: detail.name,
            content: detail.genres.first?.name ?? "",
            imageURL: detail.backdropPath
        )
        viewController.reactor = EpisodeDetailViewModel(drama: dramaEntity, season: info)
        self.rootNavigationController.pushViewController(viewController, animated: true)
        self.rootNavigationController.setNavigationBarHidden(false, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController))
    }
    
}
