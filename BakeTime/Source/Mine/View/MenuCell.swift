//
//  MenuCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/31.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = 6
        coverImageView.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
        widthConstraints.constant = PersonalMenuCell.menuCellW
        // Initialization code
    }
}
