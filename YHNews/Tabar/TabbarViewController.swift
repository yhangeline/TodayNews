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

        addchildViewControllers()
    }

    private func addchildViewControllers()
    {
        addChildViewController(HomeViewController(), title: "首页", imageName: "main")
    }
    
    private func addChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        childController.title = title
        
        let nav = NavigationViewController(rootViewController: childController)
        addChildViewController(nav)
    }
}
