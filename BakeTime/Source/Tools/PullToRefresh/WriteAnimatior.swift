//
//  WriteAnimatior.swift
//  BakeTime
//
//  Created by lyy on 2017/12/31.
//  Copyright © 2017年 lyy. All rights reserved.
//

import Foundation
import UIKit

class WriteAnimatior: NSObject, RefreshViewAnimator {
    var refreshView: WriteRefreshView
    
    init(refreshView: WriteRefreshView) {
        self.refreshView = refreshView
    }
    
    public func animate(_ state: State) {
        switch state {
        case .initial:
            self.refreshView.startDraw()
            break
        case .releasing(_):
            break
        case .loading:
            self.addAnimator(layer: self.refreshView.animateLayer!)
            break
        case .finished:
            self.refreshView.animateLayer?.speed = 0
            break
        }
    }
    
    func addAnimator(layer: CAShapeLayer) {
        layer.removeAllAnimations()
        layer.strokeColor = UIColor.black.cgColor;
        
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = (0);
        animation.toValue = (1);
        animation.repeatCount = MAXFLOAT;
        animation.autoreverses = true;
        animation.duration = CFTimeInterval(layer.bounds.size.width / 10);
        layer.add(animation, forKey: nil)
    }
}
