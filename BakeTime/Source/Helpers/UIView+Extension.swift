//
//  UIView+Extension.swift
//  BakeTime
//
//  Created by lyy on 2017/12/5.
//  Copyright © 2017年 lyy. All rights reserved.
//

import Foundation
import UIKit

// MARK: Frame

extension UIView {
    
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            frame = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            frame = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
        set {
            frame = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }
    
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
        set {
            frame = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }
    
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            frame = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
    
    var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newValue, height: frame.size.height)
        }
    }
    
    var height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: newValue)
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame = CGRect(origin: newValue, size: frame.size)
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame = CGRect(origin: frame.origin, size: newValue)
        }
    }
    
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }
    
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame = CGRect(x: newValue, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        }
    }
    
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame = CGRect(x: frame.origin.x, y: newValue, width: frame.size.width, height: frame.size.height)
        }
    }
    
    var right: CGFloat {
        get {
            return (frame.origin.x + frame.size.width)
        }
        set {
            frame = CGRect(x: newValue - frame.size.width, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        }
    }
    
    var bottom: CGFloat {
        get {
            return (frame.origin.y + frame.size.height)
        }
        set {
            frame = CGRect(x: frame.origin.x, y: (newValue - frame.size.height), width: frame.size.width, height: frame.size.height)
        }
    }
}

extension UIView {
    func addShadow(opacity: Float = 0.2, color: UIColor = UIConfig.btBlack, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0, height: 0)) {
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        UIViewController.top?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func presented(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        UIViewController.top?.navigationController?.present(viewController, animated: animated, completion: completion)
    }
}

extension UIView {
    static func nibInit() -> UIView {
        return UINib.init(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
}
