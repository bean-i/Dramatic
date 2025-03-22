//
//  DramaDetailViewController.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

import SnapKit

final class DramaDetailViewController: BaseViewController<DramaDetailView> {
    var drama: DramaDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drama = .mock
        guard let drama else { return }
        mainView.configureSnapShot(item: drama)
    }
}

@available(iOS 17.0, *)
#Preview {
    DramaDetailViewController()
}
