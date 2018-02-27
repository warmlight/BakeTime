//
//  SearchMenuController.swift
//  BakeTime
//
//  Created by lyy on 2018/2/9.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

class SearchMenuController: UIViewController {
    let cancelButton = UIButton()
    let tableView = UITableView()
    var searchBar: SearchBar?
    var collectionView: UICollectionView?
    var searchController: SearchController?
    let tags = ["When you", "eliminate", "the impossiblethe,", "whatever remains,", "however improbable,", "must be", "the truth."]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar?.starAnimation(delay: 0.4, completion: nil)
        UIView.animate(withDuration: 0.8, delay: 0.4, options: .curveLinear, animations: { 
            self.collectionView?.alpha = 1
        }, completion: nil)
    }
    
    @objc private func clickCancelButton() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: Setup UI

extension SearchMenuController {
    
    fileprivate func setup() {
        view.backgroundColor = .white
        setupUI()
        bindingSubviewsLayout()
    }
    
    private func setupUI() {
        setupCollectionView()
        setupTableView()
        setupSearchController()
    }
    
    private func bindingSubviewsLayout() {
        
        searchBar?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            } else {
                make.top.equalTo(self.view).offset(30)
            }
            make.height.equalTo(40)
        }
        
        view.layoutIfNeeded()
        
        collectionView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self.view)
            if let bar = searchBar {
                make.top.equalTo(bar.snp.bottom).offset(30)
            }
        })
    }
    
    private func setupSearchController() {
        searchController = SearchController.init(with: tableView)
        searchController?.delegate = self
        searchBar = searchController?.searchBar
        if let bar = searchBar {
            view.addSubview(bar)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupCollectionView() {
        let layout = AlignedCollectionViewFlowLayout()
        layout.horizontalAlignment = .left
        layout.estimatedItemSize = .init(width: 100, height: 40)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UINib(nibName: String(describing: TagCollectionViewCell.self), bundle:nil), forCellWithReuseIdentifier: String(describing: TagCollectionViewCell.self))
        collectionView?.alpha = 0
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = .white
        
        self.view.addSubview(collectionView!)
    }
}

// MARK: UITableViewDelegate
extension SearchMenuController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}

// MARK: UITableViewDataSource
extension SearchMenuController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension SearchMenuController: SearchControllerDelegate {
    func cancelSearch() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchMenuController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TagCollectionViewCell.self), for: indexPath) as! TagCollectionViewCell
        cell.tagLabel.text = tags[indexPath.row]
        return cell
    }
}
