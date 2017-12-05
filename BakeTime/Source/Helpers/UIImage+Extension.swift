//
//  UIImage+Extension.swift
//  BakeTime
//
//  Created by lyy on 2017/12/5.
//  Copyright © 2017年 lyy. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func originalImage(named: String) -> UIImage? {
        guard let image = UIImage(named: named) else {
            return nil
        }
        return image.withRenderingMode(.alwaysOriginal)
    }
    
    static func circleImage(named: String) -> UIImage? {
        let image = UIImage(named: named)
        return image?.circleImage
    }
    
    var circleImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let path = UIBezierPath.init(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        path.addClip()
        draw(at: .zero)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func compressImage(toByte maxLength: Int, maxWH: CGFloat) -> (image: UIImage, data: Data) {
        var resultImage = self
        var quality: CGFloat = 1.0
        
        let originWidth = self.size.width
        let originHeight = self.size.height
        let originMaxWH = max(originWidth, originHeight)
        let ratio: CGFloat = maxWH / originMaxWH
        let size: CGSize = CGSize(width: Int(originWidth * ratio),
                                  height: Int(originHeight * ratio))
        UIGraphicsBeginImageContext(size)
        resultImage.draw(in: CGRect(origin: .zero, size: size))
        resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        var data = UIImageJPEGRepresentation(resultImage, quality)!
        if data.count < maxLength {
            return (resultImage, data)
        }
        
        var maxQuality: CGFloat = 1.0
        var minQuality: CGFloat = 0.0
        for _ in 0..<6 {
            quality = (minQuality + maxQuality) / 2
            data = UIImageJPEGRepresentation(resultImage, quality)!
            if data.count > maxLength {
                maxQuality = quality
            } else if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                minQuality = quality
            } else {
                break
            }
        }
        resultImage = UIImage(data: data)!
        return (resultImage, data)
    }
}
