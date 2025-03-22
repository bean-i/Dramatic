//
//  DTSearchBar.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import UIKit
import SnapKit

final class DTSearchBar: BaseView {
    
    private let stackView = UIStackView()
    let searchBar = UISearchBar()
    private let dismissKeyboardButton = UIButton()
    
    init(with placeHolder: String) {
        searchBar.searchTextField.attributedPlaceholder = .dt(
            placeHolder,
            font: .body,
            attributes: [.foregroundColor: UIColor.dt(.semantic(.text(.primary)))]
        )
        
        super.init(frame: .zero)
    }

    override func configureHierarchy() {
        stackView.addArrangedSubviews(
            searchBar,
            dismissKeyboardButton
        )
        
        addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .secondarySystemBackground
        searchBar.tintColor = .dt(.primitive(.white))
        searchBar.searchTextField.leftView?.tintColor = .dt(.primitive(.white))
        searchBar.searchTextField.textColor = .dt(.semantic(.text(.primary)))

        dismissKeyboardButton.setTitle("취소", for: .normal)
        dismissKeyboardButton.setTitleColor(.dt(.semantic(.text(.primary))), for: .normal)
        dismissKeyboardButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
    }
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
}

@available(iOS 17.0, *)
#Preview {
    DTSearchBar(with: "드라마를 검색해 보세요.")
}
