//
//  RecommendBannerCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/19.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class RecommendBannerCell: UICollectionViewCell {
    var carouselView: CarouselView = CarouselView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        carouselView.carouselData = [CarouselModel(), CarouselModel(), CarouselModel(), CarouselModel()]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Setup UI

extension RecommendBannerCell {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupCarouselView()
    }
    
    private func bindingSubviewsLayout() {
        carouselView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    private func setupCarouselView() {
        contentView.addSubview(carouselView)
    }
}
