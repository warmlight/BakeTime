//
//  StickyPageControl.swift
//  GiveLove
//
//  Created by lyy on 2017/10/11.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class StickyPageControl: UIControl {
    var padding: CGFloat = 5
    var radius: CGFloat = 10
    var isSticky: Bool = true
    var normalItemTransparency: CGFloat = 1
    var currentPageIndicatorTintColor: UIColor?
    
    var currentPage: Int {
        return Int(round(progress))
    }
    
    var progress: Double = 0 {
        didSet {
            update(for: progress)
        }
    }
    
    var numberOfPages: Int = 0 {
        didSet {
            self.isHidden = numberOfPages == 1
            updateNumberOfPages(numberOfPages)
        }
    }
    
    fileprivate var selectedItem = UIView()
    fileprivate var normalItems = [UIView]()
    
    fileprivate var diameter: CGFloat {
        return radius * 2
    }
    
    fileprivate var firstItemFrame :CGRect? {
        let floatCount = CGFloat(normalItems.count)
        let x = (bounds.width - diameter * floatCount - padding * (floatCount - 1)) * 0.5
        let y = (bounds.height - diameter) * 0.5
        return CGRect(x: x, y: y, width: diameter, height: diameter)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateNumberOfPages(_ count: Int) {
        normalItems.forEach {$0.removeFromSuperview()}
        normalItems = (0..<count).map { _ in
            let item = UIView()
            self.addSubview(item)
            return item
        }

        self.addSubview(selectedItem)
        setNeedsLayout()
    }
    
    fileprivate func update(for progress: Double) {
        guard progress >= 0 && progress <= Double(numberOfPages - 1),
              let firstItemFrame = normalItems.first?.frame,
              numberOfPages > 1 else {
                return
        }

        var frame = selectedItem.frame
        let midpointPercent =  CGFloat(abs(round(progress) - progress)) * 2 //当前偏移量距离两个item中间点的百分比
        let itemX = (CGFloat(floor(progress)) * (diameter + padding) + firstItemFrame.origin.x)
        if round(progress) - progress > 0 {
            frame.origin.x = itemX + (1 - midpointPercent) * (diameter + padding)
        } else {
            frame.origin.x = itemX
        }
        
        let itemWidth = firstItemFrame.width
        let width = midpointPercent == 0 ? itemWidth : (padding * midpointPercent + (1 + midpointPercent) * itemWidth)
        frame.size.width = max(width, itemWidth)
        frame.size.height = diameter
        
        guard (isSticky == true ||
              progress == Double(currentPage)) else {
            return
        }

        selectedItem.frame = frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupItems()
        update(for: progress)
    }
}

// MARK: setup pagecontrol items frame

extension StickyPageControl {
    fileprivate func setupItems() {
        setupNormalItem()
        setupSelectedItem()
    }

    private func setupSelectedItem() {
        selectedItem.layer.cornerRadius = radius
        selectedItem.backgroundColor = currentPageIndicatorTintColor ?? self.tintColor
        selectedItem.frame = firstItemFrame ?? .zero
    }
    
    private func setupNormalItem() {
        var frame = firstItemFrame ?? .zero
        normalItems.forEach { (item) in
            item.backgroundColor = tintColor.withAlphaComponent(normalItemTransparency)
            item.layer.cornerRadius = radius
            item.frame = frame
            
            frame.origin.x += diameter + padding
        }
    }
}
