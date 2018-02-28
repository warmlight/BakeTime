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
    private let promptViewW: CGFloat = 80
    let promptView = HasMorePrompt.nibInit() as! HasMorePrompt

    @IBOutlet weak var collectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        widthConstraints.constant = screenW
        collectionviewHeight.constant = PersonalMenuCell.menuCellW + 50
        
        setup()
    }
}

// MARK: Setup UI

extension PersonalMenuCell {
    
    fileprivate func setup() {
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupCollectionView()
        setuppromptView()
    }
    
    private func bindingSubviewsLayout() {
        promptView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right).offset(0)
            make.height.equalTo(PersonalMenuCell.menuCellW)
            make.width.equalTo(promptViewW)
            make.top.equalTo(collectionView)
        }
        
        layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: MenuCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: MenuCell.self))
    }
    
    private func setuppromptView() {
        promptView.backgroundColor = .white
        
        collectionView.addSubview(promptView)
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

extension PersonalMenuCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.width - scrollView.contentSize.width
        if offsetX > 0 {
            if offsetX >= promptViewW {
                promptView.titleLabel.text = "<松开查看全部"
            } else {
                 promptView.titleLabel.text = "<左滑查看全部"
            }
            promptView.snp.updateConstraints({ (make) in
                make.left.equalTo(self.snp.right).offset(-offsetX)
            })
        } else {
            promptView.snp.updateConstraints({ (make) in
                make.left.equalTo(self.snp.right).offset(0)
            })
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX = scrollView.contentOffset.x + scrollView.width - scrollView.contentSize.width
        if offsetX >= promptViewW {
            self.push(ClassListController(), animated: true)
        }
    }
}
