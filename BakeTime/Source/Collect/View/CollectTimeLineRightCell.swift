//
//  CollectTimeLineRightCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class CollectTimeLineRightCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var coverBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.contentView.frame = self.frame
//        coverBgView.addShadow(opacity: 0.6, radius: 10, offset: CGSize.init(width: 0, height: 0))
    }
}
