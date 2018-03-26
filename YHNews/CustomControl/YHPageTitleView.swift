//
//  YHPageTitleView.swift
//  YHNews
//
//  Created by yh on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

private class PageTitleCell: UICollectionViewCell {
    
    var title: UILabel!
    
    var SelectedStatus: Bool = false
    
    override var isSelected: Bool{
        set {
            SelectedStatus = newValue
            title.textColor = newValue ? UIColor.red : UIColor.black
        }
        
        get {
            return SelectedStatus
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title = UILabel(frame: self.bounds)
        title.font = UIFont.systemFont(ofSize: 14)
        title.textAlignment = NSTextAlignment.center
        self .addSubview(title)
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
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
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
        cell.title.text = dataSource[indexPath.row]
        if indexPath.row == 0 {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.left)
            cell.isSelected = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView .scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
}
