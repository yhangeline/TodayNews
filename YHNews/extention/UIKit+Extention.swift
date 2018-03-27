//
//  UIKit+Extention.swift
//  YHNews
//
//  Created by yh on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable {}

extension NibLoadable {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}

extension UIView {
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
