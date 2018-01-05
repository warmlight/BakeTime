//
//  WriteRefreshView.swift
//  PullToRefreshDemo
//
//  Created by lyy on 2017/12/16.
//  Copyright © 2017年 Yalantis. All rights reserved.
//

import UIKit
import CoreText
//import PullToRefresh

class WriteRefreshView: UIView {
    
    var animateLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth]
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WriteRefreshView {
    func startDraw() {
        self.layer.sublayers?.removeAll()
        let bezierPath = self.transformToBezierPath(string: "我爱学习")
        let layer = CAShapeLayer()
        layer.bounds = bezierPath.cgPath.boundingBox
        layer.position = CGPoint.init(x: UIScreen.main.bounds.width / 2, y: 20)
        layer.isGeometryFlipped = true;
        layer.path = bezierPath.cgPath;
        layer.fillColor = UIColor.lightGray.cgColor
        layer.lineWidth = 0.5
        layer.backgroundColor = UIColor.clear.cgColor
        self.animateLayer = layer
        self.layer.addSublayer(self.animateLayer!)
    }
    
    func transformToBezierPath(string: String) -> UIBezierPath {
        let fontName = "SnellRoundhand"
        let fontRef = CTFontCreateWithName(fontName as CFString, 14, nil)
        
        let attrString = NSAttributedString(string: string, attributes: [kCTFontAttributeName as NSAttributedStringKey : fontRef])
        
        let line = CTLineCreateWithAttributedString(attrString)
        let runA = CTLineGetGlyphRuns(line)
        
        var runIndex = 0
        var i = 0
        
        let paths = CGMutablePath()
        while runIndex < CFArrayGetCount(runA){
            let run = CFArrayGetValueAtIndex(runA, runIndex);
            // 内存强制按位转换为目标的类型 obj转换为CTRun类型
            let runb = unsafeBitCast(run, to: CTRun.self)
            
            let CTFontName = unsafeBitCast(kCTFontAttributeName, to: UnsafeRawPointer.self)
            // 拿到obj:CTRun 的 font
            let runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb), CTFontName)
            // 将拿到的font 转为 CTFont类型
            let runFontS = unsafeBitCast(runFontC, to: CTFont.self)
            
            while i < CTRunGetGlyphCount(runb) {
                let range = CFRangeMake(i, 1)
                // 申请 num 个数的对应泛型类型的内存
                let glyph = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
                // 指针的内容进行初始化
                glyph.initialize(to: 0)
                
                let position = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
                position.initialize(to: .zero)
                
                CTRunGetGlyphs(runb, range, glyph)
                CTRunGetPositions(runb, range, position);
                
                let path = CTFontCreatePathForGlyph(runFontS, glyph.pointee, nil)
                let x = position.pointee.x
                let y = position.pointee.y
                let transform = CGAffineTransform(translationX: x, y: y)
                paths.addPath(path!, transform: transform)
                
                glyph.deinitialize()
                position.deinitialize()
                
                glyph.deallocate(capacity: 1)
                position.deallocate(capacity: 1)
                
                i += 1
            }
            
            runIndex += 1
        }
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.append(UIBezierPath.init(cgPath: paths))
        
        return bezierPath
    }
}
