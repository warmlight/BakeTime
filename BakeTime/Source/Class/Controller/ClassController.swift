//
//  ClassController.swift
//  BakeTime
//
//  Created by lyy on 2017/12/4.
//  Copyright © 2017年 lyy. All rights reserved.
//

import UIKit

class ClassController: UIViewController {
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        scrollViewDidScroll(collectionView!)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: Setup UI

extension ClassController {
    
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
        layout.itemSize = CGSize(width: view.frame.width, height: 150)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.bounces = false
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .white
        collectionView?.register(ClassCell.self, forCellWithReuseIdentifier:String(describing: ClassCell.self))
        
        self.view.addSubview(collectionView!)
    }
}

extension ClassController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let parallaxCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClassCell.self), for: indexPath) as! ClassCell
        parallaxCell.backgroundColor = .white
        let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight) * 150
        parallaxCell.offset(CGPoint(x: 0, y :yOffset))
        return parallaxCell
    }
}

extension ClassController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = self.collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [ClassCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight) * 150
            let xOffset = ((collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth) * 100

            parallaxCell.offset(CGPoint(x: xOffset,y :yOffset))
        }
    }
}
