//
//  Const.swift
//  YHNews
//
//  Created by yh on 2018/3/23.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

/// 屏幕的宽度
let screenWidth = UIScreen.main.bounds.width
/// 屏幕的高度
let screenHeight = UIScreen.main.bounds.height
/// emoji 宽度
let emojiItemWidth = screenWidth / 7

let IS_iPhoneX = (UIScreen.main.bounds.size.width == 375 && UIScreen.main.bounds.size.height == 812)

let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
let NAVIGATION_BAR_HEIGHT = CGFloat(44)
let TAB_BAR_HEIGHT = UIScreen.main.bounds.size.height == 812 ? CGFloat(83.0) : CGFloat(49.0)
let HOME_INDICATOR_HEIGHT = (IS_iPhoneX ? 34.0:0.0)

/// 服务器地址
//let BASE_URL = "http://lf.snssdk.com"
//let BASE_URL = "http://ib.snssdk.com"
let BASE_URL = "https://is.snssdk.com"

let device_id: String = "6096495334"
let iid: String = "5034850950"
