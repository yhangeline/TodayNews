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
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return 0.0
        }
        set(newValue) {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor()
        }
        set(newValue) {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return 0.0
        }
        set(newValue) {
            layer.borderWidth = newValue
            
        }
    }
    
    func removeAllSubviews() {

        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

extension UIImageView {
    func setImage(url: String, placeHolderImage: UIImage) {
        self.image = placeHolderImage
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: URL(string: url)!)
            let img = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = img
            }
        }
    }
}
