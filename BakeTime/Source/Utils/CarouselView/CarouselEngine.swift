//
//  CarouselEngine.swift
//  CollectionViewPage
//
//  Created by lyy on 2018/1/15.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit
import SnapKit

protocol CarouselEngineDelegate {
    func banner(_ banner: CarouselEngine, didSelectedWithIndex: Int, data: CarouselData)
    func banner(_ banner: CarouselEngine, currentIndex: Int, data: CarouselData)
    func bannerDidScroll(_ banner: UIScrollView)
}

extension CarouselEngineDelegate {
    func bannerDidScroll(_ banner: UIScrollView) {}
}

class CarouselEngine: UICollectionView {
    var carouseEngineDelegate: CarouselEngineDelegate?
    
    private var timer: Timer?
    private var customData: [CarouselData] = []
    private var originalData: [CarouselData] = []
    private var isOnlyOne = false
    
    var currentIndex = 0 {
        didSet {
            if oldValue == currentIndex {return}
            if let d = carouseEngineDelegate, currentIndex >= 0 && currentIndex < originalData.count {
                d.banner(self, currentIndex: currentIndex, data: originalData[currentIndex])
            }
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = CoverCollectionViewLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopTimer()
    }
    
    func updateCarouselWith(data: [CarouselData]) {
        originalData = data
        configData()
        self.reloadData()
    }
    
    private func configData() {
        if originalData.count > 1 {
            starTimer()
            isOnlyOne = false
            customData = originalData
            customData.insert(originalData.last!, at: 0)
            customData.append(originalData.first!)
            DispatchQueue.main.async {
                self.scrollTo(page: 1, animated: true)
            }
        } else {
            stopTimer()
            isOnlyOne = true
            customData = originalData
            currentIndex = 0
        }
    }
}

// MARK: Setup UI

extension CarouselEngine {
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.register(UINib(nibName:String(describing: CarsouelCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: CarsouelCell.self))

        self.delegate = self
        self.dataSource = self
        self.bounces = false
        self.backgroundColor = .black
        self.isPagingEnabled = true
        self.isOnlyOne = false
    }
}

extension CarouselEngine: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CarsouelCell.self), for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let d = carouseEngineDelegate {
            d.banner(self, didSelectedWithIndex: indexPath.item, data: customData[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}

// MARK: ScrollViewDelegate
extension CarouselEngine {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if originalData.count > 1 {
            starTimer()
        }
        resetPageIndex()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        resetPageIndex()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let d = carouseEngineDelegate {
            d.bannerDidScroll(scrollView)
        }
        let width = frame.width
        var index = Int(scrollView.contentOffset.x / width)
        if index == 0 {
            index = originalData.count - 1
        } else if index >= customData.count - 1 {
            index = 0
        } else {
            index = index - 1
        }
        
        currentIndex = index
    }
    
    private func resetPageIndex() {
        if contentOffset.x >= CGFloat(customData.count - 1) * bounds.width {
            scrollTo(page: 1, animated: false)
        }
        
        if contentOffset.x <= 0 {
            scrollTo(page: self.customData.count - 2, animated: false)
        }
    }
    
    private func scrollTo(page: Int, animated: Bool) {
        var tempPage = page
        if tempPage >= customData.count {
            tempPage = customData.count - 1
        } else if tempPage < 0 {
            tempPage = 0
        }
        
        self.setContentOffset(CGPoint.init(x: CGFloat(tempPage) * bounds.size.width, y: contentOffset.y), animated: animated)
    }
    
    @objc private func startScrollAutomtically() {
        self.setContentOffset(CGPoint.init(x: contentOffset.x + bounds.size.width, y: contentOffset.y), animated: true)
    }
}

// MARK: Timer
extension CarouselEngine {
    private func stopTimer() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    private func starTimer() {
        timer = Timer.init(timeInterval: 3, target: self, selector: #selector(startScrollAutomtically), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
}
