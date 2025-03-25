//
//  DTArchiveStatusView.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import UIKit
import SnapKit

final class DTArchiveStatusView: BaseView {
    
    private let stackView = UIStackView()
    let countLabel = UILabel()
    private let statusTitle = UILabel()
    
    private var title: String
    private var color: UIColor
    
    init(title: String, color: UIColor = .dt(.semantic(.text(.secondary)))) {
        self.title = title
        self.color = color
        super.init(frame: .zero)
    }
    
    override func configureHierarchy() {
        stackView.addArrangedSubviews(countLabel, statusTitle)
        addSubview(stackView)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        
        countLabel.font = .dt(.title)
        countLabel.textColor = color
        
        statusTitle.text = title
        statusTitle.font = .dt(.body)
        statusTitle.textColor = color
    }
    
}
