//
//  HotPageViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class HotPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var dataSource: [NewsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        NetWorkTool.loadApiNewsFeeds { (datas: [NewsModel]) in
            self.dataSource = datas
            self.tableView.reloadData()
        }
    }

    func layoutUI() {
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: .main), forCellReuseIdentifier: "ide")
        view.addSubview(tableView)
    }
    
}

extension HotPageViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ide") as! NewsTableViewCell
        cell.title.text = dataSource[indexPath.row].abstract
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
