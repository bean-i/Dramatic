//
//  BaseViewController.swift
//  Dramatic
//
//  Created by 이빈 on 3/20/25.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    
    var mainView: T {
        guard let customView = view as? T else {
            fatalError("view는 \(T.self) 타입이어야 합니다.")
        }
        return customView
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
