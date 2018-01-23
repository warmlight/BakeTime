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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //cell的图片offset显示不准确 reload后可正确显示
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
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: view.frame.width, height: 140)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.bounces = false
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .white
        collectionView?.register(UINib(nibName:String(describing: ClassCoverCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: ClassCoverCell.self))

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
        
        let parallaxCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClassCoverCell.self), for: indexPath) as! ClassCoverCell
        parallaxCell.backgroundColor = .white
        let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight) * yOffsetSpeed
        parallaxCell.offset(CGPoint(x: 0, y :yOffset))
        mockData(indexPath: indexPath, cell: parallaxCell)
        return parallaxCell
    }
    
    func mockData(indexPath: IndexPath, cell: ClassCoverCell) {
        switch indexPath.row {
        case 0:
            cell.imageView.image = #imageLiteral(resourceName: "pie")
            cell.chineseTitleLabel.text = "派"
            cell.englishTitleLabel.text = "Pie"
        case 1:
            cell.imageView.image = #imageLiteral(resourceName: "cake")
            cell.chineseTitleLabel.text = "蛋糕"
            cell.englishTitleLabel.text = "Cake"
        case 2:
            cell.imageView.image = #imageLiteral(resourceName: "bread")
            cell.chineseTitleLabel.text = "面包"
            cell.englishTitleLabel.text = "Bread"
        case 3:
            cell.imageView.image = #imageLiteral(resourceName: "cookie")
            cell.chineseTitleLabel.text = "饼干"
            cell.englishTitleLabel.text = "Cookie"
        default:
            break
        }
    }
}

extension ClassController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = self.collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [ClassCoverCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight) * yOffsetSpeed
            parallaxCell.offset(CGPoint(x: 0,y :yOffset))
        }
    }
}