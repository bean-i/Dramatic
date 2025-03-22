//
//  DTCellTitle.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

import SnapKit

final class DTCellTitle: BaseView {
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    private let title: String
    private let content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        
        super.init(frame: .zero)
    }
    
    override func configureView() {
        backgroundColor = .clear
        
        titleLabel.text = title
        titleLabel.font = .dt(.headline)
        titleLabel.textColor = .dt(.semantic(.text(.primary)))
        titleLabel.textAlignment = .left
        
        contentLabel.text = content
        contentLabel.font = .dt(.body)
        contentLabel.textColor = .dt(.semantic(.text(.secondary)))
        contentLabel.textAlignment = .left
    }
    
    override func configureHierarchy() {
        [titleLabel, contentLabel].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    func setTitle(_ title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }

}

@available(iOS 17.0, *)
#Preview {
    let cellTitle = DTCellTitle(title: "폭싹 속았수다", content: "드라마")
    
    let vc = UIViewController()
    vc.view.backgroundColor = .black
    vc.view.addSubview(cellTitle)
    
    cellTitle.snp.makeConstraints { make in
        make.center.equalToSuperview()
    }
    
    return vc
}
