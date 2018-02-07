//
//  LoginController.swift
//  BakeTime
//
//  Created by lyy on 2018/2/5.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    let infoBgH: CGFloat = 200
    var columnsCards = [[UIView]]()
    var visualView: UIVisualEffectView?

    var line1 = UIView()
    var line2 = UIView()
    var infoBgView = UIView()
    var loginButton = TransitionButton()
    var gradientLayer = CAGradientLayer()
    var phoneNumTextField = UITextField()
    var passwordTextField = UITextField()
    var otherLoginWayView = UINib.init(nibName: String(describing: OtherLoginWayView.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        moveAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomCustom(min: Int, max: Int) -> Int {
        let y = arc4random() % UInt32(max) + UInt32(min)
        return Int(y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if phoneNumTextField.isFirstResponder || passwordTextField.isFirstResponder {
            phoneNumTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickLoginButton() {
        loginButton.startTransition()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        infoBgView.addShadow(radius: 6, offset: CGSize.init(width: 0, height: 3))
    }
}

// MARK: - Setup UI
extension LoginController {
    
    private func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        columnsCards = setupCardWall(line: 3, column: 3)
        setupGradientBg()
        setupBlurView()
        setupInfoBgView()
        setupTextFiled()
        setupLoginButton()
        setupOtherLoginWayView()
    }
    
    private func setupCardWall(line: Int, column: Int) -> [[UIView]] {
        var cardWallColumnArr:[[UIView]] = []
        var images = [#imageLiteral(resourceName: "bread"), #imageLiteral(resourceName: "pie"), #imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "cookie"), #imageLiteral(resourceName: "Donut"), #imageLiteral(resourceName: "Macaron")]
        for i in 0..<column {
            var oneColumn = [UIView]()
            var lastView = self.view
            for j in 0..<line {
                let card = UIImageView()
                card.contentMode = .scaleAspectFill
                card.clipsToBounds = true
                card.image = images[randomCustom(min: 0, max: images.count - 1)]
                card.backgroundColor = UIColor.randomColor
                self.view.addSubview(card)
                card.snp.makeConstraints { (make) in
                    make.left.equalTo(self.view).offset(CGFloat(i) * (screenW / CGFloat(column)))
                    if j == 0 {
                        make.top.equalTo(self.view).offset(screenH / 2)
                    } else {
                        make.top.equalTo(self.view).offset(lastView?.bottom ?? 0)
                    }
                    make.width.equalTo(screenW / CGFloat(column))
                    make.height.equalTo(self.randomCustom(min: Int(screenH / 12), max: Int(screenH / 5)))
                }
                
                lastView = card
                oneColumn.append(card)
                self.view.layoutIfNeeded()
            }
            
            cardWallColumnArr.append(oneColumn)
        }
        
        return cardWallColumnArr
    }
    
    private func setupGradientBg() {
        let toColor = UIColor.white.withAlphaComponent(1)
        let middleColor = UIColor.white.withAlphaComponent(0.9)
        let fromColor = UIColor.white.withAlphaComponent(0.3)
        let gradientColors: [CGColor] = [fromColor.cgColor, middleColor.cgColor, toColor.cgColor]
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint =  CGPoint.init(x: 0, y: 1)
        gradientLayer.frame = view.frame
        
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setupInfoBgView() {
        infoBgView.alpha = 0
        infoBgView.backgroundColor = .white
        
        view.addSubview(infoBgView)
    }

    
    private func setupBlurView() {
        let blurEffect = UIBlurEffect.init(style: .light)
        visualView = UIVisualEffectView.init(effect: blurEffect)
        visualView?.frame = view.frame
        visualView?.alpha = 0
        
        view.addSubview(visualView!)
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
        
        infoBgView.addSubview(phoneNumTextField)
        infoBgView.addSubview(line1)
        infoBgView.addSubview(passwordTextField)
        infoBgView.addSubview(line2)
    }
    
    private func bindingSubviewsLayout() {
        infoBgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.snp.bottom).offset(-infoBgH / 2)
            make.width.equalTo(self.view.frame.width - 80)
            make.height.equalTo(infoBgH)
        }
        
        self.view.layoutIfNeeded()
        
        otherLoginWayView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(120)
            make.top.equalTo(infoBgView.snp.bottom).offset(screenH / 5)
        }
        
        self.view.layoutIfNeeded()
        
        phoneNumTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.right)
            make.width.equalTo(infoBgView.frame.width - 50)
            make.top.equalTo(infoBgView).offset(35)
            make.height.equalTo(30)
        }
        
        line1.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.right)
            make.width.equalTo(phoneNumTextField)
            make.top.equalTo(phoneNumTextField.snp.bottom).offset(5)
            make.height.equalTo(0.5)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.right)
            make.width.equalTo(infoBgView.frame.width - 50)
            make.top.equalTo(line1).offset(30)
            make.height.equalTo(30)
        }
        
        line2.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.right)
            make.width.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.height.equalTo(0.5)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.right)
            make.width.equalTo(180)
            make.height.equalTo(35)
            make.top.equalTo(infoBgView.snp.bottom).offset(-22)
        }

        self.view.layoutIfNeeded()
    }
    
    private func setupLoginButton() {
        loginButton.backgroundColor = UIConfig.btPink
        loginButton.setTitle("登      陆", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginButton.addTarget(self, action: #selector(clickLoginButton), for: .touchDown)
        
        infoBgView.addSubview(loginButton)
    }
    
    private func setupOtherLoginWayView() {
        view.addSubview(otherLoginWayView)
    }
}

// MARK: - Animation
extension LoginController {
    private func moveAnimation() {
        moveCards()
        moveInfoBgView()
    }
    
    private func moveCards() {
        for columnCards in columnsCards {
            var height: CGFloat = 0.0
            for (i, view) in columnCards.enumerated() {
                UIView.animate(withDuration: 1, delay: (0.2 * Double(i)) + Double(randomCustom(min: 0, max: 5)) * 0.05, options: .curveEaseOut, animations: {
                    view.snp.updateConstraints({ (make) in
                        make.top.equalTo(self.view).offset(height)
                    })
                    view.alpha = 1
                    self.view.layoutIfNeeded()
                    height += view.frame.height
                }, completion: { (_) in
                    
                })
            }
        }
    }
    
    private func moveInfoBgView() {
        UIView.animate(withDuration: 1, delay: 0.4, options: .curveLinear, animations: {
            self.infoBgView.snp.updateConstraints({ (make) in
                make.top.equalTo(self.view.snp.bottom).offset(-self.infoBgH - (self.view.frame.height - self.infoBgH) / 5 * 3)
            })
            self.infoBgView.alpha = 1
            self.view.layoutIfNeeded()
        }) { (_) in
            self.moveInfoBgSubViews()
        }
    }
    
    private func moveInfoBgSubViews() {
        for (i, view) in infoBgView.subviews.enumerated() {
            UIView.animate(withDuration: 0.7, delay: 0.1 * Double(i), options: .curveEaseOut, animations: {
                view.snp.updateConstraints({ (make) in
                    make.left.equalTo(self.view.snp.right).offset(-(screenW - self.infoBgView.x - (self.infoBgView.width - view.width) / 2))
                })
                view.alpha = 1
                self.view.layoutIfNeeded()
            }) { (_) in
                
            }
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.visualView?.alpha = 1
        }) { (_) in
            
        }
    }
}
