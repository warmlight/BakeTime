//
//  LoadingSpinnerLayer.swift
//  BakeTime
//
//  Created by lyy on 2018/2/6.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class LoadingSpinnerLayer: CAShapeLayer {
    var spinnerColor = UIColor.white {
        didSet {
            strokeColor = spinnerColor.cgColor
        }
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        let radius:CGFloat = (frame.height / 4)
        self.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        let center = CGPoint.init(x: frame.width / 2, y: frame.height / 2)
        let startAngle = Double.pi * 1.25
        let endAngle = Double.pi * 1.75
        let clockwise: Bool = true
        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath
        
        self.fillColor = nil
        self.strokeColor = spinnerColor.cgColor
        self.lineWidth = 1
    }
    
    
    
    func animation() {
        self.isHidden = false
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = Double.pi * 2
        rotate.duration = 0.4
        rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        rotate.repeatCount = HUGE
        rotate.fillMode = kCAFillModeForwards
        rotate.isRemovedOnCompletion = false
        self.add(rotate, forKey: rotate.keyPath)
    }
    
    func stopAnimation() {
        self.isHidden = true
        self.removeAllAnimations()
    }
}
