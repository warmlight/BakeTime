//
//  ClassCoverCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/22.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

let yOffsetSpeed: CGFloat = 100.0
let xOffsetSpeed: CGFloat = 100.0

class ClassCoverCell: UICollectionViewCell {
    
    @IBOutlet weak var englishTitleLabel: UILabel!
    @IBOutlet weak var chineseTitleLabel: UILabel!
    @IBOutlet weak var titleBgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleBgView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
    }
    
    var imageHeight: CGFloat {
        return (imageView.image?.size.height) ?? 0.0
    }
    
    var imageWidth: CGFloat {
        return (imageView.image?.size.width) ?? 0.0
    }
    
    
    func offset(_ offset: CGPoint) {
        imageView.frame = self.contentView.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
