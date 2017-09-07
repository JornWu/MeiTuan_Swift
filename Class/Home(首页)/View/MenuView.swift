//
//  MenuView.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/11.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class MenuView: UIView, UIScrollViewDelegate {
    
    private var imageAr = [UIImage]()
    private var titilAr = [String]()
    
    private var pageMark: UIPageControl! ///
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        analysisMenuData()
        creatDetailsView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func analysisMenuData() {
        
        let pathStr = Bundle.main.path(forResource: "menuData", ofType: "plist")
        let ar = NSArray(contentsOfFile: pathStr!)
        for i in 0 ..< ar!.count {
            let titilStr = ((ar! as NSArray)[i] as! NSDictionary)["title"] as! String
            titilAr.append(titilStr)
            let imageName = ((ar! as NSArray)[i] as! NSDictionary)["image"] as! String
            imageAr.append(UIImage(named: imageName)!)
        }
    }
    
    func creatDetailsView() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 20))
        self.addSubview(scrollView)
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: self.bounds.width * 2, height: scrollView.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        ///创建scrollview上的按钮
        let firstPage = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height))
        let secondPage = UIView(frame: CGRect(x: scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height))
        firstPage.backgroundColor = UIColor.white
        secondPage.backgroundColor = UIColor.white
        scrollView.addSubview(firstPage)
        scrollView.addSubview(secondPage)
        
        ///first page
        var firstTitleAr = [String]()
        var firstImageAr = [UIImage]()
        for i in 0 ..< 8 {
            firstTitleAr.append(titilAr[i])
            firstImageAr.append(imageAr[i])
        }
        CreatListViewItemTool.creatListViewItemWith(
            8,
            columns: 4,
            itemSize: CGSize(width: 50, height: 65),
            xSpace: (self.bounds.width - 50 * 4) / 5,
            ySpace: 10,
            itemTitle: firstTitleAr,
            titleFont: UIFont.systemFont(ofSize: 11),
            addtag: true,
            target: self,
            action: #selector(MenuView.menuItemAction(_:)),
            forControlEvents: UIControlEvents.touchUpInside,
            backgroundColor: nil,
            imageForNomals: firstImageAr,
            imageForHighlighteds: nil,
            imageForSelecteds: nil,
            parentView: firstPage,
            autoResizeParentView: false)
        
        ///second page
        var secondTitleAr = [String]()
        var secondImageAr = [UIImage]()
        for i in 8 ..< titilAr.count {
            secondTitleAr.append(titilAr[i])
            secondImageAr.append(imageAr[i])
        }
        
        CreatListViewItemTool.creatListViewItemWith(
            8,
            columns: 4,
            itemSize: CGSize(width: 50, height: 65),
            xSpace: (self.bounds.width - 50 * 4) / 5,
            ySpace: 10,
            itemTitle: secondTitleAr,
            titleFont: UIFont.systemFont(ofSize: 11),
            addtag: true,
            target: self,
            action: #selector(MenuView.menuItemAction(_:)),
            forControlEvents: UIControlEvents.touchUpInside,
            backgroundColor: nil,
            imageForNomals: secondImageAr,
            imageForHighlighteds: nil,
            imageForSelecteds: nil,
            parentView: secondPage,
            autoResizeParentView: false)
        
        pageMark = UIPageControl()
        pageMark.numberOfPages = 2
        pageMark.frame = CGRect(x: 0, y: scrollView.extHeight(), width: SCREENWIDTH, height: 20)
//        pageMark.backgroundColor = UIColor.whiteColor()
        pageMark.currentPageIndicatorTintColor = THEMECOLOR
        pageMark.pageIndicatorTintColor = UIColor.gray
        self.addSubview(pageMark)

    }
    
    func menuItemAction(_ item: UIButton) {
        ///do .....
        print(item.tag)
    }
    
    ///UIScroViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / SCREENWIDTH)
        pageMark.currentPage = page
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
