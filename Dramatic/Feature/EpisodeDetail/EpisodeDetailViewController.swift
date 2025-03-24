//
//  EpisodeDetailViewController.swift
//  Dramatic
//
//  Created by 김도형 on 3/24/25.
//

import UIKit

import ReactorKit

final class EpisodeDetailViewController: BaseViewController<EpisodeDetailView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.configureSnapShot(dramaName: "폭싹 속았수다", item: .mock)
    }
    
}
