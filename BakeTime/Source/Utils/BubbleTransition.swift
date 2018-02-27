//
//  BubbleTransition.swift
//  BakeTime
//
//  Created by lyy on 2018/1/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit
open class BubbleTransition: NSObject {
    var startingPoint = CGPoint.zero {
        didSet {
            bubble.center = startingPoint
        }
    }
    var duration = 0.3
    var transitionMode: BubbleTransitionMode = .present
    var bubbleColor: UIColor = .white
    fileprivate(set) var bubble = UIView()
    fileprivate let alphaDuration = 0.25
    @objc public enum BubbleTransitionMode: Int {
        case present, dismiss, pop
    }
}

extension BubbleTransition: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration + alphaDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
//        fromViewController?.beginAppearanceTransition(false, animated: true)
//        toViewController?.beginAppearanceTransition(true, animated: true)
        
        if transitionMode == .present || transitionMode == .dismiss {
            let presentedControllerView = transitionContext.view(forKey: .to)!
            let originalCenter = presentedControllerView.center
            let originalSize = presentedControllerView.frame.size
            
            bubble = UIView()
            bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            bubble.layer.cornerRadius = bubble.frame.size.height / 2
            bubble.center = startingPoint
            bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            bubble.backgroundColor = bubbleColor
            
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)
            containerView.addSubview(bubble)

            
            UIView.animate(withDuration: duration, animations: {
                self.bubble.transform = CGAffineTransform.identity
            }, completion: { (_) in
                presentedControllerView.alpha = 1

                UIView.animate(withDuration: self.alphaDuration, animations: {
                    self.bubble.alpha = 0
                }, completion: { (finish) in
                    self.bubble.isHidden = true
                    transitionContext.completeTransition(true)
                })
//                if self.transitionMode == .present {
//                    toViewController?.endAppearanceTransition()
//                }
//
//                fromViewController?.endAppearanceTransition()
            })
            
        } else {
            let key = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            let returningControllerView = transitionContext.view(forKey: key)!
            let originalCenter = returningControllerView.center
            let originalSize = returningControllerView.frame.size
            
            bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            bubble.layer.cornerRadius = bubble.frame.size.height / 2
            bubble.center = startingPoint
            bubble.isHidden = false
            
            UIView.animate(withDuration: duration, animations: {
                self.bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.center = self.startingPoint
                returningControllerView.alpha = 0
                
                if self.transitionMode == .pop {
                    containerView.insertSubview(returningControllerView, belowSubview: returningControllerView)
                    containerView.insertSubview(self.bubble, belowSubview: returningControllerView)
                }
            }, completion: { (_) in
                returningControllerView.center = originalCenter
                returningControllerView.removeFromSuperview()
                self.bubble.removeFromSuperview()
                transitionContext.completeTransition(true)
                
                fromViewController?.endAppearanceTransition()
                toViewController?.endAppearanceTransition()
            })
        }
    }
}

private extension BubbleTransition {
    func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
