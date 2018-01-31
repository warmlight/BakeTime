//
//  PersonalMenuCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/30.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class PersonalMenuCell: UICollectionViewCell {
    
    static let menuCellW = screenW / 4

    @IBOutlet weak var collectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        widthConstraints.constant = screenW
        collectionviewHeight.constant = PersonalMenuCell.menuCellW + 50
        
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib(nibName: String(describing: MenuCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: MenuCell.self))
    }
}

extension PersonalMenuCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuCell.self), for: indexPath)
        cell.backgroundColor = .red
//        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: PersonalMenuCell.menuCellW, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return screenW / 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
