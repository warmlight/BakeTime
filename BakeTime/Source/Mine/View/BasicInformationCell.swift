//
//  BasicInformationCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/29.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class BasicInformationCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        widthConstraints.constant = screenW
        setup()
    }
}

// MARK: Setup UI

extension BasicInformationCell {
    fileprivate func setup() {
        setupAvatarImageView()
        setupFollowButton()
    }
    
    fileprivate func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = 6
    }
    
    fileprivate func setupFollowButton() {
        followButton.layer.cornerRadius = 25
    }
}
