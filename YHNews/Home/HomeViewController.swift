//
//  HomeViewController.swift
//  YHNews
//
//  Created by yh on 2018/3/23.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, YHPageTitleViewDelegate, PageContentViewDelegate {
    
    private let navigationBar = HomeNaviView.loadViewFromNib()
    var pageTitleView: YHPageTitleView?
    var pageContentView: YHPageContentView?
    var transitionDelegate : CenterMenuDelegate = CenterMenuDelegate()
    
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
            [weak self] in

            let vc = CenterMenuController()
            vc.transitioningDelegate = self?.transitionDelegate
            vc.modalPresentationStyle = .custom
            self?.present(vc, animated: true, completion: {
                
            })
            
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

