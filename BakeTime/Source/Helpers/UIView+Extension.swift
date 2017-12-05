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
    func addShadow(opacity: Float, color: UIColor = UIConfig.btGray, radius: CGFloat = 3, offset: CGSize = CGSize(width: 5, height: 5)) {
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
