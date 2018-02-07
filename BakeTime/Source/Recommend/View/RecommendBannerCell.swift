//
//  RecommendBannerCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/19.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

// MARK: - RecommendBannerContentCell
class RecommendBannerContentCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup UI
extension RecommendBannerContentCell {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupImageView()
        setupContentView()
    }
    
    private func bindingSubviewsLayout() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "cake")
        
        contentView.addSubview(imageView)
    }
    
    private func setupContentView() {
//        contentView.layer.cornerRadius = 6
//        contentView.layer.masksToBounds = true
    }
}

// MARK: - RecommendBannerCell
class RecommendBannerCell: UICollectionViewCell {
    
    let centeredCollectionViewFlowLayout = CenteredCollectionViewFlowLayout()
    let collectionView: UICollectionView
    
    let cellPercentWidth: CGFloat = 0.92
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(centeredCollectionViewFlowLayout: centeredCollectionViewFlowLayout)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: self.bounds.width * cellPercentWidth,
            height: self.bounds.height
        )
    }
}

// MARK: Setup UI
extension RecommendBannerCell {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupCollectionView()
        setupContentView()
    }
    
    private func bindingSubviewsLayout() {
        centeredCollectionViewFlowLayout.minimumLineSpacing = 10

        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionView)
        
        collectionView.register(RecommendBannerContentCell.self, forCellWithReuseIdentifier: "RecommendBannerContentCell")
    }
}

extension RecommendBannerCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(
            width: self.bounds.width * cellPercentWidth,
            height: self.bounds.height
        )
    }
}

extension RecommendBannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendBannerContentCell", for: indexPath)
        return cell
    }
}
