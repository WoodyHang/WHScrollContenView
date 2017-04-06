//
//  WHScrollContenView.swift
//  WHScrollContentView
//
//  Created by Woodyhang on 17/4/5.
//  Copyright © 2017年 Woodyhang. All rights reserved.
//

import UIKit

typealias WHScrollContenViewHandler = (Int)->Void
class WHScrollContenView: UIView {

    var collectionView:UICollectionView!
    
    var WHCompeletionHandler:WHScrollContenViewHandler?
    
    var currentIndex:Int?{
        didSet{
            self.collectionView.scrollToItem(at: IndexPath.init(row: currentIndex!, section: 0), at: .centeredHorizontally, animated: false)
        }
    }//当前滚动到第几页，默认为0
    
    var childVC = Array<UIViewController>()
    
    var flowLayout:UICollectionViewFlowLayout!
    
    struct Const {
        static var cellIdentifier = "contentCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        self.backgroundColor = UIColor.white
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.scrollDirection = .horizontal
        self.flowLayout.itemSize = self.bounds.size
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        self.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = true
        self.flowLayout.minimumLineSpacing = 0
        self.flowLayout.minimumInteritemSpacing = 0
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Const.cellIdentifier)
        self.collectionView.backgroundColor = UIColor.white

    }
    
    func reloadViewWithChildVcs(childVcs:Array<UIViewController>,parentVC parentvC:UIViewController){
        for vc in self.childVC{
            vc.removeFromParentViewController()
        }
        self.childVC.removeAll()
        self.childVC.append(contentsOf: childVcs)
        for vc in childVcs{
            parentvC.addChildViewController(vc)
        }
        
        self.collectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let endIndex = (self.collectionView.contentOffset.x + self.collectionView.frame.width / 2) / self.collectionView.frame.width
        if self.WHCompeletionHandler != nil{
            self.WHCompeletionHandler!(Int(endIndex))
        }
    }
    
}
extension WHScrollContenView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: Const.cellIdentifier, for: indexPath)
        self.childVC[indexPath.row].view.frame = (cell?.bounds)!
        cell?.contentView.addSubview(self.childVC[indexPath.row].view)
        cell?.backgroundColor = UIColor.white
        return cell!
        
    }
}
