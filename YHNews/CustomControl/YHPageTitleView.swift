//
//  YHPageTitleView.swift
//  YHNews
//
//  Created by yh on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

private class PageTitleCell: UICollectionViewCell {
    
    private var title: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title = UILabel(frame: self.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YHPageTitleView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    private let dataSource: [String]
    
    init(frame: CGRect, titleNames: [String]) {
        dataSource = titleNames
        super.init(frame: frame)
        layoutUI()
    }
    
    func layoutUI() {
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: self.frame.size.height)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PageTitleCell.self, forCellWithReuseIdentifier: "ide")
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YHPageTitleView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PageTitleCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ide", for: indexPath) as! PageTitleCell
        return cell
    }
}
