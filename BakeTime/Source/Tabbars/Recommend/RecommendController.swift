//
//  RecommendController.swift
//  BakeTime
//
//  Created by lyy on 2017/12/4.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit
import SnapKit

class RecommendController: BaseViewController {
    
    var sourceCount = 20
    var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: Setup UI

extension RecommendController {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func bindingSubviewsLayout() {
        collectionView!.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
    
    private func setupCollectionView() {
        let layout = SpringCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: screenW, height: 100)

        self.view.addSubview(collectionView!)
        
        // Refresh control
        let animateView = WriteRefreshView()
        let refreshHeader = PullToRefresh.init(refreshView: animateView, animator: WriteAnimatior.init(refreshView: animateView), height: 40, position: .top)
        collectionView?.addPullToRefresh(refreshHeader) { DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.collectionView?.endRefreshing(at: .top)
            }
        }
    }
}

extension RecommendController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform.init(translationX: 0, y: 50)
        UIView.animate(withDuration: 1) {
            cell.transform = CGAffineTransform.identity
        }
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//        //x和y的最终值为1
//        UIView.animate(withDuration: 1) {
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//        }
    }
}
