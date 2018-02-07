//
//  OtherLoginWayView.swift
//  BakeTime
//
//  Created by lyy on 2018/2/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class OtherLoginWayView: UIView {
    @IBOutlet weak var wechatLogo: UILabel!
    @IBOutlet weak var weiboLogo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLogo()
    }
    
    func setupLogo() {
        wechatLogo.font = UIFont(name: "iconFont", size: 50)
        wechatLogo.text = IconFontType.Wechat.rawValue
        
        weiboLogo.font = UIFont(name: "iconFont", size: 50)
        weiboLogo.text = IconFontType.Weibo.rawValue
    }
}
