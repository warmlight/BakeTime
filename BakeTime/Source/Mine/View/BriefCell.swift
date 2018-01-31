//
//  BriefCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/29.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class BriefCell: UICollectionViewCell {

    @IBOutlet weak var briefLabel: UILabel!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        widthConstraints.constant = screenW
    }
}
