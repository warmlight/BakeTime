//
//  Loginself.swift
//  BakeTime
//
//  Created by lyy on 2018/2/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class LoginInfoBgView: UIView {
    let bgBothSideSpan: CGFloat = 40
    let bgViewWidth: CGFloat = screenW - 80
    let textFiledBothSideSpan: CGFloat = 25
    
    var loginButton = TransitionButton()
    var line1 = UIView()
    var line2 = UIView()
    var phoneNumTextField = UITextField()
    var passwordTextField = UITextField()

    @objc func clickLoginButton() {
        loginButton.startTransition()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveSubViews() {
        for (i, view) in self.subviews.enumerated() {
            UIView.animate(withDuration: 0.7, delay: 0.1 * Double(i), options: .curveEaseOut, animations: {
                view.snp.updateConstraints({ (make) in
                    make.left.equalTo(self.snp.left).offset((self.bgViewWidth - view.frame.width) / 2)
                })
                view.alpha = 1
                self.layoutIfNeeded()
            }) { (_) in
                
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        if view == nil {
            let point = loginButton.convert(point, from: self)
            if loginButton.bounds.contains(point) {
                view = loginButton
            }
        }
        
        return view
    }
    
//    - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//
//    {
//
//    UIView * view = [super hitTest:point withEvent:event];
//
//    if (view == nil) {
//
//    // 转换坐标系
//
//    CGPoint newPoint = [commentImageView convertPoint:point fromView:self];
//
//    // 判断触摸点是否在button上
//
//    if (CGRectContainsPoint(commentImageView.bounds, newPoint)) {
//
//    view = commentImageView;
//
//    }
//
//    }
//
//    return view;
//
//    }
}

// MARK: Setup UI

extension LoginInfoBgView {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupTextFiled()
        setupLoginButton()
    }
    
    private func setupTextFiled() {
        phoneNumTextField.alpha = 0
        phoneNumTextField.textAlignment = .center
        phoneNumTextField.backgroundColor = .clear
        phoneNumTextField.textColor = UIConfig.btBlack
        phoneNumTextField.placeholder = "用户名，没有会自动注册"
        phoneNumTextField.font = UIFont.systemFont(ofSize: 13)
        phoneNumTextField.attributedPlaceholder = NSAttributedString(string: "用户名，没有会自动注册",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIConfig.btGray])
        
        passwordTextField.alpha = 0
        passwordTextField.placeholder = "密码"
        passwordTextField.textAlignment = .center
        passwordTextField.backgroundColor = .clear
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = UIConfig.btBlack
        passwordTextField.font = UIFont.systemFont(ofSize: 13)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "密码",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIConfig.btGray])
        
        line1.alpha = 0
        line1.backgroundColor = UIConfig.btGray
        line2.alpha = 0
        line2.backgroundColor = UIConfig.btGray
        
        self.addSubview(phoneNumTextField)
        self.addSubview(line1)
        self.addSubview(passwordTextField)
        self.addSubview(line2)
    }
    
    private func setupLoginButton() {
        loginButton.backgroundColor = UIConfig.btPink
        loginButton.setTitle("登      陆", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginButton.addTarget(self, action: #selector(clickLoginButton), for: .touchDown)
        
        self.addSubview(loginButton)
    }
    
    private func bindingSubviewsLayout() {
        phoneNumTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(bgBothSideSpan + bgViewWidth)
            make.width.equalTo(bgViewWidth - 2 * textFiledBothSideSpan)
            make.top.equalTo(self).offset(35)
            make.height.equalTo(30)
        }
        
        line1.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(bgBothSideSpan + bgViewWidth)
            make.width.equalTo(phoneNumTextField)
            make.top.equalTo(phoneNumTextField.snp.bottom).offset(5)
            make.height.equalTo(0.5)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(bgBothSideSpan + bgViewWidth)
            make.width.equalTo(phoneNumTextField)
            make.top.equalTo(line1).offset(30)
            make.height.equalTo(30)
        }
        
        line2.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(bgBothSideSpan + bgViewWidth)
            make.width.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.height.equalTo(0.5)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(bgBothSideSpan + bgViewWidth)
            make.width.equalTo(180)
            make.height.equalTo(35)
            make.top.equalTo(self.snp.bottom).offset(-22)
        }
    }
}
