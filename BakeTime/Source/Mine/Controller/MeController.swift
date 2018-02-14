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
    
    @objc func clickSetting() {
    
    }
}

// MARK: Setup UI

extension MineController {
    
    fileprivate func setup() {
        setupUI()
        setupNavigationBar()
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
    
    private func setupNavigationBar() {
        let settingItem = UIButton.init(type: .custom)
        settingItem.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        settingItem.setImage(#imageLiteral(resourceName: "Settings"), for: .normal)
        settingItem.addTarget(self, action: #selector(clickSetting), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: settingItem)
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
        collectionView?.register(UINib(nibName: String(describing: BasicInformationCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: BasicInformationCell.self))
        collectionView?.register(UINib(nibName: String(describing: BriefCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: BriefCell.self))
        collectionView?.register(UINib(nibName: String(describing: PersonalMenuCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: PersonalMenuCell.self))
        collectionView?.register(UINib(nibName: String(describing: OpusCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: OpusCell.self))
        self.view.addSubview(collectionView!)
    }
}

extension MineController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BasicInformationCell.self), for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BriefCell.self), for: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PersonalMenuCell.self), for: indexPath)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OpusCell.self), for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
