//
//  CenterMenuView.swift
//  YHNews
//
//  Created by lay on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit


class CenterMenuView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.configView(temperature: 20, location: "海口")
        self.configTopView()
    }
    
    func configTopView(){
        let view = UIView(frame: CGRect(x:0, y:0, width:self.bounds.size.width, height:200))
        view.backgroundColor = UIColor.red
        self.addSubview(view)
        
        let headImageView = UIImageView(frame: CGRect(x:20, y:120, width:40, height:40))
        headImageView.layer.cornerRadius = 20
        headImageView.layer.borderWidth = 2
        headImageView.layer.borderColor = UIColor.white.cgColor
        headImageView.backgroundColor = UIColor.init(red:0.2, green:0.65, blue:0.9, alpha: 1.0)
        view.addSubview(headImageView)
        
        let nameLabel = UILabel(frame: CGRect(x:headImageView.frame.maxX+10, y:120, width:view.bounds.size.width-headImageView.frame.maxX-20, height:40))
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.text = "YHSSB"
        nameLabel.textColor = UIColor.white
        view.addSubview(nameLabel)
        
        
    }
    
    func configView(temperature:NSInteger, location:String){
        let view = UIView(frame: CGRect(x:(self.bounds.size.width)-50, y:(self.bounds.size.height)-50, width:50, height:50))
        self.addSubview(view)
        
        let tempLabel = UILabel(frame: CGRect(x:0, y:0, width:view.bounds.size.width-15, height:25))
        tempLabel.font = UIFont.systemFont(ofSize: 26)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.text = String(temperature)
        tempLabel.textColor = UIColor.init(red:0.2, green:0.65, blue:0.9, alpha: 1.0)
        view.addSubview(tempLabel)
        
        let oLabel = UILabel(frame: CGRect(x:tempLabel.bounds.size.width-2, y:-2, width:12, height:12))
        oLabel.font = UIFont.systemFont(ofSize: 15)
        oLabel.textAlignment = NSTextAlignment.center
        oLabel.text = "o"
        oLabel.textColor = UIColor.init(red:0.2, green:0.65, blue:0.9, alpha: 1.0)
        view.addSubview(oLabel)
        
        let locatlabel = UILabel(frame: CGRect(x:0, y:25, width:tempLabel.bounds.size.width, height:15))
        locatlabel.font = UIFont.systemFont(ofSize: 12)
        locatlabel.textAlignment = NSTextAlignment.center
        locatlabel.text = location
        locatlabel.textColor = UIColor.black
        view.addSubview(locatlabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

