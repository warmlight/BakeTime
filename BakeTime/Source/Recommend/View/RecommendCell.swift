//
//  RecommendCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var coverBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverBgView.addShadow(opacity: 0.3, offset: CGSize.init(width: 0, height: 10))
        titleView.addShadow(opacity: 0.3, radius: 4, offset: CGSize.init(width: 0, height: 5))
    }
}

// MARK: Setup UI
extension RecommendCell {
    private func setupUI() {
        setupTitleView()
    }
    
    private func setupTitleView() {
        titleView.clipsToBounds = true
        titleView.layer.cornerRadius = 4
        titleView.layer.masksToBounds = false
    }
}
