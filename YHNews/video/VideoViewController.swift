//
//  VideoViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/27.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var dataSource: [VideoModel] = []
    private var tableView: UITableView!
    private lazy var playerView = YHVideoPlayer.loadViewFromNib()
    private var currentVideoCell: VideoTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutUI()
        
        NetWorkTool.loadVideoNewsFeeds { (datas: [VideoModel]) in
            self.dataSource = datas
            self.tableView?.reloadData()
        }
    }
    
    func layoutUI() {
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT-STATUS_BAR_HEIGHT), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: .main), forCellReuseIdentifier: "ide")
        tableView.register(VideoTableViewCell.self)
        view.addSubview(tableView)
    }
}

extension VideoViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as VideoTableViewCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.subviews.contains(playerView) ?? false {
            return
        }
        currentVideoCell = (cell as! VideoTableViewCell)
        cell?.addSubview(playerView)
        playerView.playVideo(urlString: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
    }
    
    //当播放器cell划出屏幕时移除
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard currentVideoCell != nil else {
            return
        }
        
        if tableView.visibleCells.contains(currentVideoCell!) == false {
            playerView.removeFromSuperview()
            currentVideoCell = nil
        }
    }
    
}
