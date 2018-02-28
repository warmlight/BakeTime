//
//  AlignedCollectionViewFlowLayout.swift
//  AlignCollectionViewFlowLayout
//
//  Created by lyy on 2018/2/26.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

protocol Alignment {}

enum HorizontalAlignment: Alignment {
    case left
    case right
    case justified
}

public enum VerticalAlignment: Alignment {
    case top
    case center
    case bottom
}

struct AlignmentAxis<T: Alignment> {
    let alignment: T
    let position: CGFloat
}

class AlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var horizontalAlignment: HorizontalAlignment = .justified
    var verticalAlignment: VerticalAlignment = .center

    private var contentWidth: CGFloat {
        guard let collectionViewWidth = collectionView?.frame.width else {
            return 0
        }
        return collectionViewWidth - sectionInset.left - sectionInset.right
    }
    
    var alignmentAxis: AlignmentAxis<HorizontalAlignment>? {
        switch horizontalAlignment {
        case .left:
            return AlignmentAxis.init(alignment: .left, position: sectionInset.left)
        case .right:
            guard let collectionViewWidth = collectionView?.frame.size.width else {
                return nil
            }
            return AlignmentAxis.init(alignment: .right, position: collectionViewWidth - sectionInset.right)
        default:
            return nil
        }
    }
    
    // MARK: initialization
    init(horizontalAlignment: HorizontalAlignment = .justified, verticalAlignment: VerticalAlignment = .center) {
        super.init()
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        
        if horizontalAlignment != .justified {
            layoutAttributes.alignHorizontal(collectionViewLayout: self)
        }
    
        if verticalAlignment != .center {
            layoutAttributes.alignVertical(collectionViewLayout: self)
        }
        
        return layoutAttributes
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesObjects = copy(super.layoutAttributesForElements(in: rect))
        layoutAttributesObjects?.forEach({ (layoutAttributes) in
            setFrame(for: layoutAttributes)
        })
        return layoutAttributesObjects
    }
    // MARK: -Helper
    
    fileprivate func originalLayoutAttribute(forItemAt indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
    private func setFrame(for layoutAttributes: UICollectionViewLayoutAttributes) {
        if layoutAttributes.representedElementCategory == .cell {
            if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                layoutAttributes.frame = newFrame
            }
        }
    }
    
    // 返回当前item的前一个item是否与当前line的frame相交 借此判断当前item是否是当前行的第一个item
    fileprivate func isInTheSameLine(currentItemAttributes:UICollectionViewLayoutAttributes, anotherAttributes: UICollectionViewLayoutAttributes) -> Bool {
        let currentItemFrame = currentItemAttributes.frame
        let lineFrame = CGRect.init(x: sectionInset.left,
                                    y: currentItemFrame.origin.y,
                                    width: contentWidth,
                                    height:currentItemFrame.height)
        return lineFrame.intersects(anotherAttributes.frame)
    }
    private func copy(_ layoutAttributesArray: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributesArray?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
    }
    
    // MARK: Veritical Helper
    fileprivate func layoutAttributes(forItemsInLineWith layoutAttributes: UICollectionViewLayoutAttributes) -> [UICollectionViewLayoutAttributes] {
        var lineFrame = layoutAttributes.frame
        lineFrame.origin.x = sectionInset.left
        lineFrame.size.width = contentWidth
        return super.layoutAttributesForElements(in: lineFrame) ?? []
    }
    
    fileprivate func verticalAlignmentAxis(for currentItemLayoutAttributes: UICollectionViewLayoutAttributes) -> AlignmentAxis<VerticalAlignment>? {
        let layoutAttributesInLine = layoutAttributes(forItemsInLineWith: currentItemLayoutAttributes)
        return verticalAlignmentAxisForLine(with: layoutAttributesInLine)
    }
    
    private func verticalAlignmentAxisForLine(with layoutAttributes: [UICollectionViewLayoutAttributes]) -> AlignmentAxis<VerticalAlignment>? {
        guard let firstItemInLine = layoutAttributes.first else {
            return nil
        }
        switch verticalAlignment {
        case .top:
            let minY = layoutAttributes.reduce(CGFloat.greatestFiniteMagnitude) {min($0, $1.frame.minY)}
            return AlignmentAxis.init(alignment: .top, position: minY)
        case .bottom:
            let maxY = layoutAttributes.reduce(0) {max($0, $1.frame.maxY)}
            return AlignmentAxis.init(alignment: .bottom, position: maxY)
        default:
            let centerY = firstItemInLine.center.y
            return AlignmentAxis.init(alignment: .center, position: centerY)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

fileprivate extension UICollectionViewLayoutAttributes {
    private var currentSection: Int {
        return indexPath.section
    }
    
    private var currentItem: Int {
        return indexPath.item
    }

    private var precedingIndexPath: IndexPath {
        return IndexPath(item: currentItem - 1, section: currentSection)
    }
    
    private var followingIndexPath: IndexPath {
        return IndexPath(item: currentItem + 1, section: currentSection)
    }
    
    private func alignFirstItemInLine(to alignmentAxis: AlignmentAxis<HorizontalAlignment>) {
        switch alignmentAxis.alignment {
        case .left:
            frame.origin.x = alignmentAxis.position
        case .right:
            frame.origin.x = alignmentAxis.position - frame.width
        default:
            break
        }
    }
    
    private func alignToPreItem(collectionViewLayout: AlignedCollectionViewFlowLayout) {
        let itemSpacing = collectionViewLayout.minimumInteritemSpacing //水平间距
        if let preItemAttributes = collectionViewLayout.layoutAttributesForItem(at: precedingIndexPath) {
            frame.origin.x = preItemAttributes.frame.maxX + itemSpacing
        }
    }
    
    private func alignToFollowItem(collectionViewLayout: AlignedCollectionViewFlowLayout) {
        let itemSpacing = collectionViewLayout.minimumInteritemSpacing //水平间距
        if let followItem = collectionViewLayout.layoutAttributesForItem(at: followingIndexPath) {
            frame.origin.x = followItem.frame.minX - frame.width - itemSpacing
        }
    }
    
    private func alignVertical(to alignmentAxis: AlignmentAxis<VerticalAlignment>) {
        switch alignmentAxis.alignment {
        case .top:
            frame.origin.y = alignmentAxis.position
        case .bottom:
            frame.origin.y = alignmentAxis.position - frame.size.height
        default:
            center.y = alignmentAxis.position
        }
    }
    
   private func isRepresentingFirstItemInLine(collectionViewLayout: AlignedCollectionViewFlowLayout) -> Bool {
        if currentItem == 0 {
            return true
        } else {
            if let preItem = collectionViewLayout.originalLayoutAttribute(forItemAt: precedingIndexPath) {
                return !collectionViewLayout.isInTheSameLine(currentItemAttributes: self, anotherAttributes: preItem)
            } else {
                return false
            }
        }
    }
    
    private func isRepresentingLastItemInLine(collectionViewLayout: AlignedCollectionViewFlowLayout) -> Bool {
        guard let itemCount = collectionViewLayout.collectionView?.numberOfItems(inSection: currentSection) else {
            return false
        }
        
        if currentItem >= itemCount - 1 {
            return true
        } else {
            if let layoutAttributesForFollowingItem = collectionViewLayout.originalLayoutAttribute(forItemAt: followingIndexPath) {
                return !collectionViewLayout.isInTheSameLine(currentItemAttributes: self, anotherAttributes: layoutAttributesForFollowingItem)
            }
            else {
                return true
            }
        }
    }
    
    func alignHorizontal(collectionViewLayout: AlignedCollectionViewFlowLayout) {
        guard let alignmentAxis = collectionViewLayout.alignmentAxis else {
            return
        }
        
        switch collectionViewLayout.horizontalAlignment {
        case .left:
            if isRepresentingFirstItemInLine(collectionViewLayout: collectionViewLayout) {
                alignFirstItemInLine(to: alignmentAxis)
            } else {
                alignToPreItem(collectionViewLayout: collectionViewLayout)
            }
        case .right:
            if isRepresentingLastItemInLine(collectionViewLayout: collectionViewLayout) {
                alignFirstItemInLine(to: alignmentAxis)
            } else {
                alignToFollowItem(collectionViewLayout: collectionViewLayout)
            }
        default:
            return
        }
    }
    
    func alignVertical(collectionViewLayout: AlignedCollectionViewFlowLayout) {
        guard let alignmentAxis = collectionViewLayout.verticalAlignmentAxis(for: self) else {
            return
        }
        alignVertical(to: alignmentAxis)
    }
}
