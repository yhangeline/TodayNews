//
//  YHPageContentView.swift
//  YHNews
//
//  Created by yh on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class YHPageContentView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    let controllers: [UIViewController]
     private var collectionView: UICollectionView!
    
    init(frame: CGRect, childControllers: [UIViewController]) {
        controllers = childControllers
        super.init(frame: frame)
        layoutUI()
    }
    
    private func layoutUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: self.frame.size.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ide")
        collectionView.isPagingEnabled = true
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension YHPageContentView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "ide", for: indexPath)
        cell.removeAllSubviews()
        let vc = controllers[indexPath.row]
        vc.view.frame = cell.bounds
        cell.addSubview(vc.view)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}
