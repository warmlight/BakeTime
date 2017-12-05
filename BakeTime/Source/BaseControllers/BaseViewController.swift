//
//  BaseViewController.swift
//  BakeTime
//
//  Created by lyy on 2017/11/28.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var supportInteractivePop = true

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
