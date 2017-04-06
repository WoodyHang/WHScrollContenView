//
//  ViewController.swift
//  WHScrollContentView
//
//  Created by Woodyhang on 17/4/5.
//  Copyright © 2017年 Woodyhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var titleView:WHScrollTitleView?
    
    var contentView:WHScrollContenView?
    
    var vcs = [WHTestViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let titleArray:NSMutableArray = ["首页","体育","科技","生活","本地","视频","娱乐","时尚","房地产","经济"]
        if titleView == nil{
            titleView = WHScrollTitleView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
            
            self.view.addSubview(titleView!)
            
        }
        if contentView == nil {
            contentView = WHScrollContenView(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 60))
            self.view.addSubview(contentView!)
            
        }
        
        
        
        titleView?.selelctedColor = UIColor.purple
        self.edgesForExtendedLayout = []
        
        titleView?.reloadViewWithData(titles: titleArray)
        titleView?.indicatorHeight = 10
        titleView?.titleFont = UIFont.boldSystemFont(ofSize: 20)
        weak var weakSelf = self
        titleView?.scrollHandler = {(index) in
            weakSelf?.contentView?.currentIndex = index
            
        }
        contentView?.WHCompeletionHandler = {(index) in
            weakSelf?.titleView?.selectedIndex = index
        }
        
        for title in titleArray{
            let vc = WHTestViewController()
            vc.titleString = title as! String
            vcs.append(vc)
        }
        contentView?.reloadViewWithChildVcs(childVcs: vcs, parentVC: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

