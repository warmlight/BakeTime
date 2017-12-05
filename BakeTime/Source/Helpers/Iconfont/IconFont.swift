//
//  IconFont.swift
//  BakeTime
//
//  Created by lyy on 2017/12/4.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    func setTitle(iconfont: IconFontType, fontSize: CGFloat, for state: UIControlState = .normal) {
        titleLabel?.font = UIFont(name: "iconFont", size: fontSize)
        setTitle(iconfont.rawValue, for: state)
    }
}

extension UILabel {
    convenience init(iconfont: IconFontType, fontSize: CGFloat) {
        self.init()
        font = UIFont(name: "iconFont", size: fontSize)
        text = iconfont.rawValue
    }
}

extension UIImage {
    
    static func icon(fontSize: CGFloat, text: IconFontType, imageColor: UIColor = UIColor.black) -> UIImage {
        let size = CGSize(width: fontSize, height: fontSize)
        return self.icon(imageSize: size, text: text, imageColor: imageColor)
    }
    
    static func icon(imageSize: CGSize, text: IconFontType, imageColor: UIColor = UIColor.black) -> UIImage {
        defer {
            UIGraphicsEndImageContext()
        }
        let rect = CGRect.init(origin: .zero, size: imageSize)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setAllowsAntialiasing(true)
        guard let iconfont = UIFont(name: "iconfont", size: imageSize.height) else {
            return UIImage()
        }
        text.rawValue.draw(in: rect, withAttributes: [NSAttributedStringKey.font: iconfont, NSAttributedStringKey.foregroundColor: imageColor])
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        } else {
            return UIImage()
        }
    }
}
