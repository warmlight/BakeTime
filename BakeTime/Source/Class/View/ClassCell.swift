//
//  ClassCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/21.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0

class ClassCell: UICollectionViewCell {
    var imageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    
    func showCell(with: CarouselModel) {
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: Setup UI

extension ClassCell {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupImageView()
    }
    
    private func bindingSubviewsLayout() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    private func setupImageView() {
        contentView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "test2")
        contentView.addSubview(imageView)

    }
}
