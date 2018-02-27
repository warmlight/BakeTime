//
//  SearchBar.swift
//  Search
//
//  Created by lyy on 2018/2/22.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

protocol SearchBarDelegate {
    func textDidChange(text: String)
    func cancelAction()
}

extension SearchBarDelegate {
    func textDidChange(text: String) {}
    func cancelAction() {}
}

class SearchBar: UIView {
    let bubble = SearchBubble.init(frame: .zero)
    let cancelButton = UIButton()
    var delegate: SearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func starAnimation(delay: Double, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.8, delay: delay, usingSpringWithDamping: 0.85, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.bubble.snp.updateConstraints({ (make) in
                make.left.equalTo(self).offset(30)
                make.right.equalTo(self.snp.right).offset(-80)
            })
            self.bubble.showContent()
            self.cancelButton.alpha = 1

            self.layoutIfNeeded()
        }) { (_) in
            self.bubble.textField.becomeFirstResponder()
            if let finish = completion {
                finish()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: Setup UI

extension SearchBar {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupSearchBubble()
        setupCancelButton()
        setupSearchBubbleAction()
    }
    
    private func bindingSubviewsLayout() {
        bubble.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self.snp.right).offset(-40)
            make.left.equalTo(self).offset(UIScreen.main.bounds.width)
            make.height.equalTo(40)
        }

        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(bubble.snp.right).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(bubble)
        }
    }
    
    private func setupSearchBubble() {
        bubble.backgroundColor = UIColor.init(hex: "F3F3F3")
        bubble.layer.cornerRadius = 20

        addSubview(bubble)
    }
    
    private func setupCancelButton() {
        cancelButton.alpha = 0
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)

        addSubview(cancelButton)
    }
    
    private func setupSearchBubbleAction() {
        bubble.cleanButton.addTarget(self, action: #selector(clickCleanButton), for: .touchUpInside)
        bubble.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}

// MARK: Action
extension SearchBar {
    
    @objc private func clickCancelButton() {
        if let d = delegate {
            d.cancelAction()
        }
    }
    
    @objc private func clickCleanButton() {
        bubble.textField.text = ""
        if let d = delegate {
            d.textDidChange(text: bubble.textField.text ?? "")
        }
    }
    
    @objc private func textFieldDidChange() {
        if let d = delegate {
            d.textDidChange(text: bubble.textField.text ?? "")
        }
    }
}
