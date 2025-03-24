//
//  DTTabButton.swift
//  Dramatic
//
//  Created by 이빈 on 3/24/25.
//

import UIKit
import SnapKit

final class DTTabButton: UIButton {
    
    private var title: String
    
    private let stackView = UIStackView()
    private let button = UIButton()
    private let underLineView = UIView()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        stackView.addArrangedSubviews(button, underLineView)
        addSubview(stackView)
    }
    
    private func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func configureView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.dt(.semantic(.text(.secondary))), for: .normal)
        button.setTitleColor(.dt(.primitive(.white)), for: .selected)
        button.titleLabel?.font = .dt(.headline)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        underLineView.backgroundColor = .dt(.primitive(.white))
        underLineView.isHidden = true
    }
    
    @objc private func buttonTapped() {
        button.isSelected.toggle()
        underLineView.isHidden = !button.isSelected
    }
}
