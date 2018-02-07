//
//  TransitionButton.swift
//  BakeTime
//
//  Created by lyy on 2018/2/6.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class TransitionButton: UIButton {
    var isExpand = true
    var cacheTitle: String?
    var spinner: LoadingSpinnerLayer = LoadingSpinnerLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(spinner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startTransition() {
        cacheTitle = title(for: .normal)
        setTitle("", for: .normal)
        
        let shrinkAnim                   = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue             = frame.width
        shrinkAnim.toValue               = frame.height
        shrinkAnim.duration              = 0.2
        shrinkAnim.timingFunction        = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        shrinkAnim.fillMode              = kCAFillModeForwards
        shrinkAnim.isRemovedOnCompletion = false
        
        layer.removeAllAnimations()
        layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
        
        isExpand = false
        spinner.frame = self.frame
        spinner.animation()
    }
    
    func resetButtonTransition() {
        setTitle(cacheTitle, for: .normal)
        
        let shrinkAnim                   = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue             = frame.height
        shrinkAnim.toValue               = frame.width
        shrinkAnim.duration              = 0.2
        shrinkAnim.timingFunction        = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        shrinkAnim.fillMode              = kCAFillModeForwards
        shrinkAnim.isRemovedOnCompletion = false
        
        layer.removeAllAnimations()
        layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
        isExpand = true
        spinner.stopAnimation()
    }
}
