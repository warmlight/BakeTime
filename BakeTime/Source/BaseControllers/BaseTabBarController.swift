//
//  BaseTabBarController.swift
//  BakeTime
//
//  Created by lyy on 2017/11/28.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    fileprivate let itemSize: CGFloat = 18.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubControllers()

        let items = UITabBarItem.appearance()

        var normalAttr: [NSAttributedStringKey: Any] = [:]
        normalAttr[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 11)
        normalAttr[NSAttributedStringKey.foregroundColor] = UIConfig.btGray
        var selecAttr: [NSAttributedStringKey: Any] = [:]
        selecAttr[NSAttributedStringKey.foregroundColor] = UIConfig.btBlack

        items.setTitleTextAttributes(normalAttr, for: .normal)
        items.setTitleTextAttributes(selecAttr, for: .selected)
        items.titlePositionAdjustment = UIOffsetMake(0, -2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Setup

extension BaseTabBarController {
    func setupSubControllers() {
        //Recommend
        let recommendItem = UITabBarItem(title: "推荐",
                                         image: UIImage.icon(fontSize: itemSize, text: IconFontType.Recommend, imageColor: UIConfig.btGray).withRenderingMode(.alwaysOriginal),
                                         selectedImage: UIImage.icon(fontSize: itemSize, text: IconFontType.RecommendFill, imageColor: UIConfig.btBlack).withRenderingMode(.alwaysOriginal))
        let recommendNav = BaseNavigationController(rootViewController: RecommendController())
        recommendNav.tabBarItem = recommendItem
        
        //Class
        let classItem = UITabBarItem(title: "分类",
                                     image: UIImage.icon(fontSize: itemSize, text: IconFontType.Class, imageColor: UIConfig.btGray).withRenderingMode(.alwaysOriginal),
                                     selectedImage:UIImage.icon(fontSize: itemSize, text: IconFontType.ClassFill, imageColor: UIConfig.btBlack).withRenderingMode(.alwaysOriginal))
        let classNav = BaseNavigationController(rootViewController: ClassController())
        classNav.tabBarItem = classItem
        
        //Follow
        let followItem = UITabBarItem(title: "收藏",
                                      image: UIImage.icon(fontSize: itemSize, text: IconFontType.Collect, imageColor: UIConfig.btGray).withRenderingMode(.alwaysOriginal),
                                      selectedImage: UIImage.icon(fontSize: itemSize, text: IconFontType.CollectFill, imageColor: UIConfig.btBlack).withRenderingMode(.alwaysOriginal))
        let followNav = BaseNavigationController(rootViewController: CollectController())
        followNav.tabBarItem = followItem
        
        //Mine
        let mineItem = UITabBarItem(title: "我的",
                                    image: UIImage.icon(fontSize: itemSize, text: IconFontType.Mine, imageColor: UIConfig.btGray).withRenderingMode(.alwaysOriginal),
                                    selectedImage: UIImage.icon(fontSize: itemSize, text: IconFontType.MineFill, imageColor: UIConfig.btBlack).withRenderingMode(.alwaysOriginal))
        let mineNav = BaseNavigationController(rootViewController: MineController())
        mineNav.tabBarItem = mineItem
        
        viewControllers = [recommendNav, classNav, followNav, mineNav]
        tabBar.isTranslucent = false
    }
}
