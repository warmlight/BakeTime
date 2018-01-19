//
//  BubbleTransition.swift
//  BakeTime
//
//  Created by lyy on 2018/1/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit
open class BubbleTransition: NSObject {
    open var startingPoint = CGPoint.zero {
        didSet {
            bubble.center = startingPoint
        }
    }
    open var duration = 0.5
    open var transitionMode: BubbleTransitionMode = .present
    open var bubbleColor: UIColor = .white
    open fileprivate(set) var bubble = UIView()
    @objc public enum BubbleTransitionMode: Int {
        case present, dismiss, pop
    }
}

extension BubbleTransition: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)

        fromViewController?.beginAppearanceTransition(false, animated: true)
        toViewController?.beginAppearanceTransition(true, animated: true)

        if transitionMode == .present {
            let presentedControllerView = transitionContext.view(forKey: .to)!
            let originalCenter = presentedControllerView.center
            let originalSize = presentedControllerView.frame.size

            bubble = UIView()
            bubble.frame = frameForBubble(originalCenter, size: originalSize, start: startingPoint)
            bubble.layer.cornerRadius = bubble.frame.size.height / 2
            bubble.center = startingPoint
            bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            bubble.backgroundColor = bubbleColor
            containerView.addSubview(bubble)

            presentedControllerView.center = startingPoint
            presentedControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)

            UIView.animate(withDuration: duration, animations: {
                self.bubble.transform = CGAffineTransform.identity
                presentedControllerView.transform = CGAffineTransform.identity
                presentedControllerView.alpha = 1
                presentedControllerView.center = originalCenter
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
                    self.bubble.isHidden = true
                    fromViewController?.endAppearanceTransition()
                    toViewController?.endAppearanceTransition()
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
