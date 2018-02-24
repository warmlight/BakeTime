//
//  SearchController.swift
//  Search
//
//  Created by lyy on 2018/2/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

protocol SearchControllerDelegate {
    func cancelSearch()
}

class SearchController: UIViewController {
    var delegate: SearchControllerDelegate?
    let searchBar = SearchBar.init(frame: .zero)
    var tableView: UITableView
    
    init(with resultTableView: UITableView) {
        self.tableView = resultTableView
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: Setup UI

extension SearchController {
    
    fileprivate func setup() {
        searchBar.delegate = self
    }
}

extension SearchController: SearchBarDelegate {
    func textDidChange(text: String) {
        if text == "" {
            print("列表消失")
            tableView.removeFromSuperview()
        } else {
            if let controller = searchBar.controller() {
                controller.view.addSubview(tableView)
            }
            tableviewLayout()
            print("列表出现 过滤查询")
        }
    }
    
    func cancelAction() {
        searchBar.bubble.textField.resignFirstResponder()
        
        if let d = delegate {
            d.cancelSearch()
            print("dismiss")
        }
    }
    
    func tableviewLayout() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            if let controller = searchBar.controller() {
                make.left.bottom.right.equalTo(controller.view)
            }
        }
    }
}
