//
//  RecommendController.swift
//  BakeTime
//
//  Created by lyy on 2017/12/4.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class RecommendController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let v = UIView()
        v.backgroundColor = .red
        v.frame = CGRect.init(x: 100, y: 100, width: 50, height: 50)
        v.addShadow(opacity: 0.7, offset: CGSize.init(width: 0, height: 5))
        self.view.addSubview(v)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
