//
//  VideoViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/27.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataSource: [VideoModel] = []
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutUI()
        
        NetWorkTool.loadVideoNewsFeeds { (datas: [VideoModel]) in
            self.dataSource = datas
            self.tableView?.reloadData()
        }
    }
    
    func layoutUI() {
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: .main), forCellReuseIdentifier: "ide")
        view.addSubview(tableView)
    }
}

extension VideoViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ide") as! VideoTableViewCell
        let model = dataSource[indexPath.row]
        cell.nameLabel.text = model.title
        cell.userLabel.text = model.name
        cell.playCountLabel.text = "\(model.read_count!)次播放"
        cell.videoImg.setImage(url: model.video_imgUrl, placeHolderImage: UIImage(named: "timg")!)
        cell.avatarImg.setImage(url: model.avatar_url, placeHolderImage: UIImage(named: "timg")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
