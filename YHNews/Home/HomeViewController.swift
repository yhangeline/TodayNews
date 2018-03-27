//
//  HomeViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/23.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let navigationBar = HomeNaviView.loadViewFromNib()
    var pageTitleView: YHPageTitleView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutNavigationBar()
    
        NetWorkTool.loadHomeNewTitleData { (arr: [HomeTitleModel]) in
            let titles: [String] = arr.flatMap({ (model) -> String? in
                model.name
            })
            self.pageTitleView = YHPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40), titleNames: titles)
            self.view.addSubview(self.pageTitleView!)
        }
        
        navigationBar.block = {
            
            let vc = UIViewController()
            let ctr:CenterMenuController =
                CenterMenuController.init(presentedViewController: self, presenting: self)
            vc.transitioningDelegate = ctr
            vc.modalPresentationStyle = .custom
            vc.view.backgroundColor = UIColor.red
            vc.view = CenterMenuView.init(frame: CGRect(x:0,y:0,width: screenWidth/3*2,height:screenHeight))
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }

}


extension HomeViewController { 
    private func layoutNavigationBar(){
        view.backgroundColor = UIColor.white
        navigationItem.titleView = navigationBar
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        
    }
}
