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
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .black
        collectionView?.alwaysBounceVertical = true
        
        layout.itemSize = CGSize(width: 100, height: 100)

        self.view.addSubview(collectionView!)
        
        let v = WriteRefreshView()
        let obj = PullToRefresh.init(refreshView: v, animator: WriteAnimatior.init(refreshView: v), height: 40, position: .top)
        collectionView?.addPullToRefresh(obj) { DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}

//// MARK: Setup UI
//
//extension RecommendController {
//
//    fileprivate func setup() {
//        setupUI()
//        bindingSubviewsLayout()
//    }
//
//    private func setupUI() {
//        setupTableView()
//    }
//
//    private func bindingSubviewsLayout() {
//        tableView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(view)
//            make.top.equalTo(topLayoutGuide.snp.bottom)
//            make.bottom.equalTo(bottomLayoutGuide.snp.top)
//        }
//    }
//
//    private func setupTableView() {
//        tableView.frame = .zero
//        tableView.estimatedRowHeight = 0;
//        tableView.estimatedSectionHeaderHeight = 0;
//        tableView.estimatedSectionFooterHeight = 0;
//
//        view.addSubview(tableView)
//
//        let v = WriteRefreshView()
//        let obj = PullToRefresh.init(refreshView: v, animator: WriteAnimatior.init(refreshView: v), height: 40, position: .top)
//        tableView.addPullToRefresh(obj) { DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            self.tableView.endRefreshing(at: .top)
//            }
//        }
//
//        let d = DefaultRefreshView()
//        let pull = PullToRefresh.init(refreshView: d, animator: DefaultViewAnimator(refreshView: d), height: 40, position: .bottom)
//        tableView.addPullToRefresh(pull) {DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            self.sourceCount = 25
//            self.tableView.reloadData()
//            self.tableView.endRefreshing(at: .bottom)
//        }
//        }
//    }
//}

