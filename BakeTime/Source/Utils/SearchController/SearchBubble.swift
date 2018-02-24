//
//  SearchBubble.swift
//  Search
//
//  Created by lyy on 2018/2/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class SearchBubble: UIView {
    private let bubbleView = UIView()
    let textField = UITextField()
    let cleanButton = UIButton.init(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showContent() {
        self.textField.alpha = 1
        self.cleanButton.alpha = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: Setup UI

extension SearchBubble {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupTextField()
        setupCleanButton()
    }
    
    private func bindingSubviewsLayout() {
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(cleanButton.snp.left).offset(0)
            make.top.equalTo(self)
            make.height.equalTo(40)
        }
        
        cleanButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-8)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self)
        }
        
        layoutIfNeeded()
    }
    
    private func setupTextField() {
        let searchIcon = UIImageView.init(image: #imageLiteral(resourceName: "SearchContactsBarIcon"))
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.frame = CGRect.init(x: 0, y: 10, width: 30, height: 15)
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        textField.placeholder = "搜索菜谱"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.alpha = 0

        addSubview(textField)
    }
    
    private func setupCleanButton() {
        cleanButton.setImage(#imageLiteral(resourceName: "cleanSearch"), for: .normal)
        cleanButton.alpha = 0
        addSubview(cleanButton)
    }
}
