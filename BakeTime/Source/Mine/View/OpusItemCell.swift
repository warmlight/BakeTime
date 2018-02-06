//
//  OpusItemCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/31.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class OpusItemCell: UICollectionViewCell {

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint.constant = PersonalMenuCell.menuCellW
    }
}
