//
//  MineController.swift
//  BakeTime
//
//  Created by lyy on 2017/12/4.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class MineController: BaseViewController {
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationController?.navigationBar.clipsToBounds = true
    }
}

// MARK: Setup UI

extension MineController {
    
    fileprivate func setup() {
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
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.estimatedItemSize = CGSize.init(width: view.width, height: 200)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .black
        collectionView?.register(UINib(nibName: String(describing: BasicInformationCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: BasicInformationCell.self))
        collectionView?.register(UINib(nibName: String(describing: BriefCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: BriefCell.self))
        collectionView?.register(UINib(nibName: String(describing: PersonalMenuCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: PersonalMenuCell.self))
        
        self.view.addSubview(collectionView!)
    }
}

extension MineController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BriefCell.self), for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BriefCell.self), for: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PersonalMenuCell.self), for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

