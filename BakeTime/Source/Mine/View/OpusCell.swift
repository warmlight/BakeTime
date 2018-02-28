//
//  OpusCell.swift
//  BakeTime
//
//  Created by lyy on 2018/1/31.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class OpusCell: UICollectionViewCell {

    private let promptViewW: CGFloat = 80
    let promptView = HasMorePrompt.nibInit() as! HasMorePrompt
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var widthConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraints: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        widthConstraints.constant = screenW

        setup()
    }
}

// MARK: Setup UI

extension OpusCell {
    
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
            make.height.equalTo(collectionView)
            make.width.equalTo(promptViewW)
            make.top.equalTo(collectionView)
        }
        
        layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        collectionViewHeightConstraints.constant = PersonalMenuCell.menuCellW
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: OpusItemCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: OpusItemCell.self))
    }
    
    private func setuppromptView() {
        promptView.backgroundColor = .white
        
        collectionView.addSubview(promptView)
    }
}

extension OpusCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OpusItemCell.self), for: indexPath)
        cell.backgroundColor = .red
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

extension OpusCell {
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
