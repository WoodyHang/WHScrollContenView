//
//  WHScrollTitleView.swift
//  WHScrollContentView
//
//  Created by Woodyhang on 17/4/5.
//  Copyright © 2017年 Woodyhang. All rights reserved.
//

import UIKit

typealias WHViewSelectedHanlder = (Int)->Void
class WHScrollTitleView: UIView {
    
    
    var scollView:UIScrollView!
    
    var titleButtons = Array<UIButton>()
    
    /**
     文字未选中的颜色,默认为黑色
     */
    var normalColor:UIColor!
    
    var selelctedColor:UIColor!{
        didSet{
            if oldValue != nil {
                self.selectionIndicator.backgroundColor = selelctedColor
            }
        }
    }//文字及下面的滚动条颜色，默认为红色
    
    var selectedIndex:Int?{
        didSet{
            if (oldValue != nil) {
                if selectedIndex == oldValue{
                    return
                }
                let btn = self.scollView.viewWithTag(oldValue! + 100) as! UIButton
                btn.isSelected = false
                let selectedBtn = self.scollView.viewWithTag(selectedIndex! + 100) as! UIButton
                selectedBtn.isSelected = true
                self.setSelctionIndicator(animated: true)
            }
        }
    }//选中第几个标题
    
    var titleWidth:CGFloat?//每个标题的宽度
    
    var titleFont:UIFont!{
        didSet{
            if oldValue != nil {
                for btn in self.titleButtons{
                    btn.titleLabel?.font = titleFont
                }
            }
        }
    }//标题的字体
    
    var indicatorHeight:CGFloat?//指示条高度
    
    var selectionIndicator:UIView!//文字下面的指示器
    
    //typealias titleViewSelectedHanlder = (Int) -> Void
    
    var scrollHandler:WHViewSelectedHanlder?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        initData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initData()
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI(){
        scollView = UIScrollView()
        scollView.scrollsToTop = false
        scollView.showsHorizontalScrollIndicator = false
        scollView.showsVerticalScrollIndicator = false
        self.addSubview(scollView)
        self.selectionIndicator = UIView()
        self.selectionIndicator.backgroundColor = self.selelctedColor
        scollView.addSubview(selectionIndicator)
    }
    
    func initData(){
        self.selectedIndex = 0
        self.normalColor = UIColor.black
        self.selelctedColor = UIColor.red
        self.titleFont = UIFont.systemFont(ofSize: 14)
        self.indicatorHeight = 2.0
        self.titleWidth = 85.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scollView.frame = self.bounds
        self.scollView.contentSize = CGSize(width: CGFloat(self.titleButtons.count) * titleWidth!, height: self.frame.size.height)
        var i = 0
        for btn in self.titleButtons{
            btn.frame = CGRect(x: self.titleWidth! * CGFloat(i), y: 0, width: self.titleWidth!, height: self.frame.size.height)
            i += 1
        }
        
        setSelctionIndicator(animated: false)
    }
    
    func setSelctionIndicator(animated:Bool){
        UIView.animate(withDuration: animated ?0.02:0, animations: {
            self.selectionIndicator.frame = CGRect(x: CGFloat(self.selectedIndex!) * self.titleWidth!,
                                                   y: self.frame.height - self.indicatorHeight!,
                                                   width: self.titleWidth!,
                                                   height: self.indicatorHeight!)
        }) { (finished) in
            self.scrollRectToVisibleCenteredOn(visibleRect: self.selectionIndicator.frame, animated: true)
        }
    }
    
    func scrollRectToVisibleCenteredOn(visibleRect:CGRect,animated:Bool){
        let centerRect = CGRect(x: visibleRect.origin.x + visibleRect.size.width / 2 - self.scollView.frame.width / 2,
                                y: visibleRect.origin.y + visibleRect.size.height / 2 - self.scollView.frame.height / 2,
                                width: self.scollView.frame.size.width,
                                height: self.scollView.frame.size.height)
        self.scollView.scrollRectToVisible(centerRect, animated: animated)
    }
    
    func reloadViewWithData(titles:NSMutableArray){
        for btn in self.titleButtons{
            btn.removeFromSuperview()
        }
       // self.titleButtons.removeAll()
        
        var i = 0
        for title in titles{
            let btn = UIButton(type: .custom)
            if i == self.selectedIndex!{
                btn.isSelected = true
            }
            btn.tag = 100 + i
            btn.addTarget(self, action: #selector(btnClicked), for: .touchDown)
            btn.setTitle(title as? String, for: .normal)
            btn.titleLabel?.font = self.titleFont
            btn.setTitleColor(self.normalColor, for: .normal)
            btn.setTitleColor(self.selelctedColor, for: .selected)
            self.scollView.addSubview(btn)
            self.titleButtons.append(btn)
            i += 1
        }
        self.layoutSubviews()
    }
    
    func btnClicked(sender:UIButton){
        let btnIndex = sender.tag - 100
        guard btnIndex != self.selectedIndex! else {
            return
        }
        self.selectedIndex = btnIndex
        if scrollHandler != nil {
            scrollHandler!(self.selectedIndex!)
        }
    }
}















