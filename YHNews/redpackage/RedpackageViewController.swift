//
//  RedpackageViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/29.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class RedpackageViewController: UITableViewController {

    let titles = ["BasicAnimation","keyFrameAnimation","transition","customAnimation"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "不知道写啥"
        view.backgroundColor = .white
        
    }
}


extension RedpackageViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ide")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ide")
        }
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
}
