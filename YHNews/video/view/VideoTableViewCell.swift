//
//  VideoTableViewCell.swift
//  YHNews
//
//  Created by yh on 2018/3/27.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    var str: String
    let aaa: String
    
    init() {
        aaa = "123"
        str = "123"
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "s")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
