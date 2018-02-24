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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    @objc func clickSetting() {
        let searchMenuController = SearchMenuController()
        searchMenuController.transitioningDelegate = self
        self.navigationController?.present(searchMenuController, animated: true, completion: nil)
    }
}

extension RecommendController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionAnimator = BubbleTransition()
        transitionAnimator.bubbleColor = UIConfig.btPink
        let button = self.navigationItem.rightBarButtonItem?.value(forKey: "view") as? UIButton
        let searchItemFrame = button?.superview?.convert(button?.center ?? .zero, to: UIApplication.shared.keyWindow) ?? .zero

        transitionAnimator.startingPoint = searchItemFrame
        return transitionAnimator
    }
}

// MARK: Setup UI

extension RecommendController {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func bindingSubviewsLayout() {
        collectionView!.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
    }
    
    private func setupNavigationBar() {
        let settingItem = UIButton.init(type: .custom)
        settingItem.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        settingItem.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        settingItem.addTarget(self, action: #selector(clickSetting), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: settingItem)
    }
    
    private func setupCollectionView() {
        let layout = SpringCollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: screenW, height: 265)
        if #available(iOS 11.0, *) {
            layout.sectionInsetReference = .fromSafeArea
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .never
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(UINib(nibName:String(describing: RecommendCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: RecommendCell.self))
        collectionView?.register(RecommendBannerCell.self, forCellWithReuseIdentifier: String(describing: RecommendBannerCell.self))

        view.addSubview(collectionView!)
        
        // Refresh control
        let animateView = WriteRefreshView()
        let refreshHeader = PullToRefresh.init(refreshView: animateView, animator: WriteAnimatior.init(refreshView: animateView), height: 60, position: .top)
        collectionView?.addPullToRefresh(refreshHeader) { DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.collectionView?.endRefreshing(at: .top)
            }
        }
    }
}

extension RecommendController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecommendBannerCell.self), for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecommendCell.self), for: indexPath) as! RecommendCell
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - collectionView.frame.width.truncatingRemainder(dividingBy: 2)
        return CGSize(width: cellWidth, height: 265)
    }
}
