//
//  BaseViewController.swift
//  Dramatic
//
//  Created by 이빈 on 3/20/25.
//

import UIKit

class BaseViewController<T: BaseView>: UIViewController {
    
    var mainView: T {
        guard let customView = view as? T else {
            fatalError("view는 \(T.self) 타입이어야 합니다.")
        }
        return customView
    }
    
    override func loadView() {
        self.view = T(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    func configureNavigation() { }

}
