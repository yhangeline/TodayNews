//
//  VideoTableViewCell.swift
//  YHNews
//
//  Created by yh on 2018/3/27.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell, ReusableView, NibLoadable {
    
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
