//
//  ExploreFlow.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import UIKit
import RxFlow

final class ExploreFlow: Flow {
    
    var root: Presentable {
        return self.rootNavigationController
    }
    
    private let rootNavigationController: UINavigationController
    
    init() {
        self.rootNavigationController = UINavigationController()
        self.rootNavigationController.navigationBar.tintColor = .dt(.semantic(.icon(.secondary)))
        self.rootNavigationController.tabBarItem.image = UIImage(systemName: "sparkles")
        self.rootNavigationController.tabBarItem.title = "탐색"
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? ExploreStep else { return .none }
        switch step {
        case .initialScreen:
            return navigateToExploreScreen()
        case .dramaDetail(let id):
            return navigateToDramaDetailScreen(id: id)
        }
    }
    
    private func navigateToExploreScreen() -> FlowContributors {
        let viewController = ExploreViewController()
        self.rootNavigationController.pushViewController(viewController, animated: false)
        self.rootNavigationController.setNavigationBarHidden(true, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController))
    }
    
    private func navigateToDramaDetailScreen(id: Int) -> FlowContributors {
        let viewController = DramaDetailViewController(viewModel: DramaDetailViewModel(id: id))
        self.rootNavigationController.pushViewController(viewController, animated: true)
        self.rootNavigationController.setNavigationBarHidden(false, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController))
    }
    
}
