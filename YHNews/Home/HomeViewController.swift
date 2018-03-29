//
//  HomeViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/23.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, YHPageTitleViewDelegate, PageContentViewDelegate {
    
    let navigationBar = HomeNaviView.loadViewFromNib()
    var pageTitleView: YHPageTitleView?
    var pageContentView: YHPageContentView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutNavigationBar()
    
        NetWorkTool.loadHomeNewTitleData { (arr: [HomeTitleModel]) in
            let titles: [String] = arr.flatMap({ (model) -> String? in
                model.name
            })
            self.pageTitleView = YHPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40), titleNames: titles)
            self.pageTitleView?.delegate = self
            self.view.addSubview(self.pageTitleView!)
            
            for _ in arr {
                self.addChildViewController(HotPageViewController())
            }
            self.pageContentView = YHPageContentView(frame: CGRect(x: 0, y: 40, width: screenWidth, height: screenHeight-40), childControllers: self.childViewControllers)
            self.pageContentView?.delegate = self
            self.view.addSubview(self.pageContentView!)
            
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
    }
    
    func pageTitleViewDidSeleced(atIndex index: Int) {
        pageContentView?.setIndex(index: index)
    }
    
    func pageContentViewDidEndScroll(index: Int) {
        pageTitleView?.setIndex(index: index)
    }
    
}

