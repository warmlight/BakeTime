//
//  SearchMenuController.swift
//  BakeTime
//
//  Created by lyy on 2018/2/9.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

//class SearchMenuController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
//    deinit {
//        print("dealloc")
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
////    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        self.dismiss(animated: true, completion: nil)
//    }
//}

class SearchMenuController: UIViewController {
    let cancelButton = UIButton()
    let tableView = UITableView()
    
    var searchBar: SearchBar?
    var searchController: SearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar?.starAnimation(delay: 0.8)
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
        setupTableView()
        setupSearchController()
    }
    
    private func bindingSubviewsLayout() {
        searchBar?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(30)
            make.height.equalTo(40)
        }
        
        view.layoutIfNeeded()
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
