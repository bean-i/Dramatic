//
//  LibraryViewController.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import UIKit
import SnapKit

final class LibraryViewController: BaseViewController<LibraryView> {
    
    
    override func configureNavigation() {
        let title = UILabel()
        title.text = "보관함"
        title.textColor = .dt(.semantic(.text(.primary)))
        title.font = .dt(.largeTitle)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: title)
    }
    
}
