//
//  CoverCollectionViewLayoutAttributes.swift
//  CollectionViewPage
//
//  Created by lyy on 2018/1/13.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class CoverCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    public var scrollDirection: UICollectionViewScrollDirection = .vertical
    public var middleOffset: CGFloat = 0
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CoverCollectionViewLayoutAttributes
        copy.scrollDirection = scrollDirection
        copy.middleOffset = middleOffset
        return copy
    }
}

class CoverCollectionViewLayout: UICollectionViewFlowLayout {
    public override class var layoutAttributesClass: AnyClass { return CoverCollectionViewLayoutAttributes.self }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        return attributes.flatMap { $0 as? CoverCollectionViewLayoutAttributes }.map { self.transformLayoutAttributes($0) }
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func transformLayoutAttributes(_ attributes: CoverCollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else { return attributes }
        
        let a = attributes
        
        let distance: CGFloat
        let itemOffset: CGFloat
        
        if scrollDirection == .horizontal {
            distance = collectionView.frame.width
            itemOffset = a.center.x - collectionView.contentOffset.x
        } else {
            distance = collectionView.frame.height
            itemOffset = a.center.y - collectionView.contentOffset.y
        }
        
        a.scrollDirection = scrollDirection
        a.middleOffset = itemOffset / distance - 0.5
        
        self.addAnimatorTo(attributes: attributes)
        
        return a
    }
    
    func addAnimatorTo(attributes: CoverCollectionViewLayoutAttributes) {
        let speed: CGFloat = 0.5
        let position = attributes.middleOffset
        let direction = attributes.scrollDirection
        
        guard let contentView = self.collectionView?.cellForItem(at: attributes.indexPath)?.contentView else {
            return
        }
        
        if abs(position) >= 1 {
            contentView.frame = attributes.bounds
        } else if direction == .horizontal {
            let width = collectionView?.frame.width ?? 0
            let transitionX = -(width * speed * position)
            let transform = CGAffineTransform(translationX: transitionX, y: 0)
            let newFrame = attributes.bounds.applying(transform)
            
            contentView.frame = newFrame
        } else {
            let height = collectionView?.frame.height ?? 0
            let transitionY = -(height * speed * position)
            let transform = CGAffineTransform(translationX: 0, y: transitionY)
            let newFrame = attributes.bounds.applying(transform)
            contentView.frame = newFrame
        }
    }
}
