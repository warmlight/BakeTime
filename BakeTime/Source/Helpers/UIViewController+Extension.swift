//
//  UIViewController+Extension.swift
//  BakeTime
//
//  Created by lyy on 2018/1/19.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

extension UIViewController {
    class var top : UIViewController? {
        let windows = UIApplication.shared.windows
        var rootViewController : UIViewController?
        
        for window in windows {
            if let windowRootViewController = window.rootViewController {
                rootViewController = windowRootViewController
                break
            }
        }
        return self.top(of: rootViewController)
    }
    
    /// Returns the top most view controller from given view controller's stack.
    class func top(of viewController: UIViewController? ) -> UIViewController? {
        /// UITabBarController
        if let tabBarViewController = viewController as? UITabBarController, let selectedViewController = tabBarViewController.selectedViewController {
            return self.top(of: selectedViewController)
        }
        
        /// UINavigationController
        if let navigationCotroller = viewController as? UINavigationController, let visibleController = navigationCotroller.visibleViewController {
            return self.top(of: visibleController)
        }
        
        /// presentedViewController
        if let presentViewController = viewController?.presentedViewController {
            return self.top(of: presentViewController)
        }
        
        /// child viewController
        for subView in viewController?.view?.subviews ?? [] {
            if let childViewController = subView.next as? UIViewController {
                return self.top(of: childViewController)
            }
        }
        
        return viewController
    }
}
