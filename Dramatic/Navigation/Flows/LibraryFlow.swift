//
//  LibraryFlow.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import UIKit
import RxFlow

final class LibraryFlow: Flow {
    
    var root: Presentable {
        return self.rootNavigationController
    }
    
    private let rootNavigationController: UINavigationController
    
    init() {
        self.rootNavigationController = UINavigationController()
        self.rootNavigationController.navigationBar.tintColor = .dt(.semantic(.icon(.secondary)))
        self.rootNavigationController.tabBarItem.image = UIImage(systemName: "tray.full")
        self.rootNavigationController.tabBarItem.title = "보관함"
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? LibraryStep else { return .none }
        switch step {
        case .initialScreen:
            return navigateToLibraryScreen()
        case .dramaDetail(let id):
            return navigateToDramaDetailScreen(id: id)
        }
    }
    
    private func navigateToLibraryScreen() -> FlowContributors {
        let viewController = LibraryViewController()
        self.rootNavigationController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController))
    }
    
    private func navigateToDramaDetailScreen(id: Int) -> FlowContributors {
        let viewController = DramaDetailViewController(viewModel: DramaDetailViewModel(id: id))
        self.rootNavigationController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController))
    }
    
}
