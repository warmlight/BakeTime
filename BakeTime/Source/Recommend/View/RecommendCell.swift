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
        let images = [#imageLiteral(resourceName: "Donut"), #imageLiteral(resourceName: "Macaron"), #imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "Donut"), #imageLiteral(resourceName: "cookie"), #imageLiteral(resourceName: "Macaron")]
        coverImage.image = images[randomCustom(min: 0, max: 5)]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverBgView.addShadow(opacity: 0.2, radius: 3, offset: CGSize.init(width: 0, height: 0))
    }
    
    func randomCustom(min: Int, max: Int) -> Int {
        let y = arc4random() % UInt32(max) + UInt32(min)
        return Int(y)
    }
}

// MARK: Setup UI
extension RecommendCell {
    private func setupUI() {
        setupTitleView()
        setupCoverImage()
    }
    
    private func setupTitleView() {
//        titleView.clipsToBounds = true
//        titleView.layer.cornerRadius = 0
//        titleView.layer.masksToBounds = true
    }
    
    private func setupCoverImage() {
        coverImage.layer.cornerRadius = 6
    }
}
