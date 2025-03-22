//
//  DTHeader.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import UIKit
import SnapKit

final class DTHeader: BaseView {
    
    private let titleLabel = UILabel()
    private let subUnderLineView = UIView()
    private let mainUnderLineView = UIView()
    
    init(title: String) {
        titleLabel.text = title
        super.init(frame: .zero)
    }
    
    override func configureHierarchy() {
        addSubViews(
            titleLabel,
            subUnderLineView,
            mainUnderLineView
        )
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
        
        subUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        mainUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(titleLabel.snp.trailing).offset(5)
            make.height.equalTo(1)
        }
        
    }
    
    override func configureView() {
        titleLabel.font = .dt(.headline)
        titleLabel.textColor = .dt(.semantic(.text(.primary)))
        
        subUnderLineView.backgroundColor = .secondarySystemBackground
        mainUnderLineView.backgroundColor = .dt(.primitive(.white))
    }
    
}
