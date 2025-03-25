//
//  AppFlow.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import UIKit
import RxFlow

final class AppFlow: Flow {
    var root: Presentable {
        return self.tabBarController
    }
    
    private let tabBarController: UITabBarController
    
    init() {
        self.tabBarController = UITabBarController()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .dt(.semantic(.bg(.primary)))
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.dt(.semantic(.text(.brand)))]
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.tabBar.tintColor = .dt(.semantic(.text(.brand)))
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .initialScreen:
            return setupTabBar()
        }
    }
    
    private func setupTabBar() -> FlowContributors {
        let exploreFlow = ExploreFlow()
        let searchFlow = SearchFlow()
        let libraryFlow = LibraryFlow()
        
        Flows.use(exploreFlow, searchFlow, libraryFlow, when: .created) { [unowned self] exploreRoot, searchRoot, libraryRoot in // unowned?
            self.tabBarController.setViewControllers([exploreRoot, searchRoot, libraryRoot], animated: false)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: exploreFlow, withNextStepper: OneStepper(withSingleStep: ExploreStep.initialScreen)),
            .contribute(withNextPresentable: searchFlow, withNextStepper: OneStepper(withSingleStep: SearchStep.initialScreen)),
            .contribute(withNextPresentable: libraryFlow, withNextStepper: OneStepper(withSingleStep: LibraryStep.initialScreen))
        ])
    }
    
    
}
