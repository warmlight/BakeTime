//
//  CarouselView.swift
//  CollectionViewPage
//
//  Created by lyy on 2018/1/15.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit
import SnapKit

protocol CarouselData {
    var imageUrl: String {get set}
    var linkUrl: String {get set}
}

protocol CarouselViewDelegate {
    func didSelectedData(_ data: CarouselData)
}

class CarouselView: UIView {
    var delegate: CarouselViewDelegate?
    private var carouselView: CarouselEngine
    private let pageControl = StickyPageControl()
    var carouselData: [CarouselData] = [] {
        didSet {
            carouselView.updateCarouselWith(data: carouselData)
            pageControl.numberOfPages = carouselData.count
        }
    }
    
    override init(frame: CGRect) {
        carouselView = CarouselEngine.init(frame: .zero, collectionViewLayout: CoverCollectionViewLayout())
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup UI

extension CarouselView {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupCarouselView()
        setupPageControl()
    }
    
    private func bindingSubviewsLayout() {
        carouselView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(10)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
    
    private func setupCarouselView() {
        carouselView.carouseEngineDelegate = self
        self.addSubview(carouselView)
    }
    
    private func setupPageControl() {
        pageControl.radius = 3
        pageControl.padding = 6
        pageControl.progress = 0.0
        pageControl.tintColor = .gray
        pageControl.currentPageIndicatorTintColor = .orange
        
        self.addSubview(pageControl)
    }
}

extension CarouselView: CarouselEngineDelegate {
    func bannerDidScroll(_ banner: UIScrollView) {
        if banner.contentOffset.x < banner.bounds.width ||  banner.contentOffset.x > (banner.contentSize.width - banner.bounds.width) {
            return
        }
        // 计算当前偏移量（出去首尾手动添加的两个视觉差的cell宽度）
        let contentOffsetX = banner.contentOffset.x - banner.bounds.width
        let totalWidth = banner.bounds.width * CGFloat(carouselData.count - 1)
        let percent = Double(contentOffsetX / totalWidth)
        let progress = percent * Double(carouselData.count - 1)
        pageControl.progress = progress
    }
    
    func banner(_ banner: CarouselEngine, currentIndex: Int, data: CarouselData) {
        pageControl.progress = Double(currentIndex)
    }
    
    func banner(_ banner: CarouselEngine, didSelectedWithIndex: Int, data: CarouselData) {
        if let d = delegate {
            d.didSelectedData(data)
        }
    }
}
