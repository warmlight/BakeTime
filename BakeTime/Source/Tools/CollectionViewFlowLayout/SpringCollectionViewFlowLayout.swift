//
//  SpringCollectionViewFlowLayout.swift
//  BakeTime
//
//  Created by lyy on 2018/1/5.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit
import Foundation

class SpringCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var dynamicAnimator: UIDynamicAnimator = UIDynamicAnimator()
    var visibleIndexPathsSet: NSMutableSet = NSMutableSet()
    var latestDelta: CGFloat = 0
    
    override init() {
        super.init()
        dynamicAnimator = UIDynamicAnimator.init(collectionViewLayout: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        let collectionViewRect = CGRect.init(origin: self.collectionView?.bounds.origin ?? .zero, size: self.collectionView?.frame.size ?? .zero)
        let visibleRect = collectionViewRect.insetBy(dx: 0, dy:-600)
        let itemsInVisibleRectArray = super.layoutAttributesForElements(in: visibleRect) ?? [UICollectionViewLayoutAttributes]()
        let visibleRectIndexPathsArray = itemsInVisibleRectArray.map({
            $0.indexPath
        })
        let itemsIndexPathsInVisibleRectSet = NSSet.init(array: visibleRectIndexPathsArray)
        
        let attachmentBehavior = self.dynamicAnimator.behaviors as! [UIAttachmentBehavior]
        
        let noLongerVisibleBehaviours = attachmentBehavior.filter {
            let attributes = $0.items.first as! UICollectionViewLayoutAttributes
            return itemsIndexPathsInVisibleRectSet.member(attributes.indexPath) == nil
        }
        
        for behaviour in noLongerVisibleBehaviours {
            self.dynamicAnimator.removeBehavior(behaviour)
            let attributes = behaviour.items.first as! UICollectionViewLayoutAttributes
            self.visibleIndexPathsSet.remove(attributes.indexPath)
        }
        
        let newlyVisibleItems = itemsInVisibleRectArray.filter {
            return self.visibleIndexPathsSet.member($0.indexPath) == nil
        }
        
        for item in newlyVisibleItems {
            let springBehaviour = UIAttachmentBehavior.init(item: item, attachedToAnchor: item.center)
            springBehaviour.length = 0
            springBehaviour.damping = 0.8
            springBehaviour.frequency = 1
            
            self.dynamicAnimator.addBehavior(springBehaviour)
            self.visibleIndexPathsSet.add(item.indexPath)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return dynamicAnimator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCell(at:indexPath)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        latestDelta = newBounds.origin.y - collectionView!.bounds.origin.y
        
        let touchLocation = collectionView?.panGestureRecognizer.location(in: collectionView) ?? .zero
        
        let attachmentBehavior = self.dynamicAnimator.behaviors as! [UIAttachmentBehavior]
        for springBehaviour in attachmentBehavior {
            let yDistanceFromTouch: CGFloat = fabs(touchLocation.y - springBehaviour.anchorPoint.y)
            let xDistanceFromTouch: CGFloat = fabs(touchLocation.x - springBehaviour.anchorPoint.x)
            let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0
            let item = springBehaviour.items.first!
            var center = item.center;

            if latestDelta < 0 {
                center.y += max(self.latestDelta, self.latestDelta * scrollResistance)
            } else {
                center.y += min(self.latestDelta, self.latestDelta * scrollResistance)
            }
            
            item.center = center
            
            self.dynamicAnimator.updateItem(usingCurrentState: item)
        }
        
        return false
    }
}
