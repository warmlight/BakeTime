//
//  BaseNavigationController.swift
//  BakeTime
//
//  Created by lyy on 2017/11/28.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let backItem = UIBarButtonItem(image: UIImage(named: "nav_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navBackPop))
            viewController.navigationItem.leftBarButtonItem = backItem
        }
        super.pushViewController(viewController, animated: animated)
        
        //iphoneX上push会出现上移的问题，重置frame
        self.tabBarController?.tabBar.frame.origin.y = UIScreen.main.bounds.height - (self.tabBarController?.tabBar.frame.size.height)!
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        for vc in viewControllers.dropFirst() where vc.navigationItem.leftBarButtonItem == nil {
            let item = UIBarButtonItem(image: UIImage(named: "nav_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navBackPop))
            vc.navigationItem.leftBarButtonItem = item
        }
        
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    @objc func navBackPop() {
        popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        var supportInteractivePop = true
        if let vc = viewControllers.last as? BaseViewController {
            supportInteractivePop = vc.supportInteractivePop
        }
        
        return (viewControllers.count == 1 ? false : true) && supportInteractivePop
    }
}

// MARK: - Status Bar

extension BaseNavigationController {
    override var prefersStatusBarHidden: Bool {
        if let lastVC = viewControllers.last, lastVC.prefersStatusBarHidden {
            return true
        }
        
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last?.preferredStatusBarStyle ?? .default
    }
}
