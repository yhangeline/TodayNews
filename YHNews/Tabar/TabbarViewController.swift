//
//  TabbarViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/23.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(displayP3Red: 177/255.0, green: 79/255.0, blue: 71/255.0, alpha: 1)
        addchildViewControllers()
    }

    private func addchildViewControllers()
    {
        addChildViewController(HomeViewController(), title: "首页", imageName: "home")
        addChildViewController(VideoViewController(), title: "视频", imageName: "video")
    }
    
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        childController.title = title
        
        let nav = NavigationViewController(rootViewController: childController)
        addChildViewController(nav)
    }
}
