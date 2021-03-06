//
//  CollectController.swift
//  BakeTime
//
//  Created by lyy on 2017/12/4.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class CollectController: BaseViewController {

    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.collectionView?.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: Setup UI

extension CollectController {
    
    fileprivate func setup() {
        view.backgroundColor = .white
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func bindingSubviewsLayout() {
        collectionView?.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UINib(nibName:String(describing: CollectTimeLineLeftCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: CollectTimeLineLeftCell.self))
        collectionView?.register(UINib(nibName:String(describing: CollectTimeLineRightCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: CollectTimeLineRightCell.self))
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .white
        
        layout.itemSize = CGSize(width: screenW, height: screenW / 2.2)
        
        self.view.addSubview(collectionView!)
    }
}

extension CollectController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectTimeLineLeftCell.self), for: indexPath)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell

        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectTimeLineRightCell.self), for: indexPath) as! CollectTimeLineRightCell
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        }
        
    }
}
