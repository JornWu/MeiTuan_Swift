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
        self.backgroundColor = UIColor.whiteColor()
        analysisMenuData()
        creatDetailsView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func analysisMenuData() {
        
        let pathStr = NSBundle.mainBundle().pathForResource("menuData", ofType: "plist")
        let ar = NSArray(contentsOfFile: pathStr!)
        for var i = 0; i < ar!.count; i++ {
            let titilStr = ar![i]["title"] as! String
            titilAr.append(titilStr)
            let imageName = ar![i]["image"] as! String
            imageAr.append(UIImage(named: imageName)!)
        }
    }
    
    func creatDetailsView() {
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, self.bounds.width, self.bounds.height - 20))
        self.addSubview(scrollView)
        scrollView.delegate = self
        
        scrollView.contentSize = CGSizeMake(self.bounds.width * 2, scrollView.bounds.height)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        ///创建scrollview上的按钮
        let firstPage = UIView(frame: CGRectMake(0, 0, scrollView.bounds.width, scrollView.bounds.height))
        let secondPage = UIView(frame: CGRectMake(scrollView.bounds.width, 0, scrollView.bounds.width, scrollView.bounds.height))
        firstPage.backgroundColor = UIColor.whiteColor()
        secondPage.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(firstPage)
        scrollView.addSubview(secondPage)
        
        ///first page
        var firstTitleAr = [String]()
        var firstImageAr = [UIImage]()
        for var i = 0; i < 8; i++ {
            firstTitleAr.append(titilAr[i])
            firstImageAr.append(imageAr[i])
        }
        CreatListViewItemTool.creatListViewItemWith(
            8,
            columns: 4,
            itemSize: CGSizeMake(50, 65),
            xSpace: (self.bounds.width - 50 * 4) / 5,
            ySpace: 10,
            itemTitle: firstTitleAr,
            titleFont: UIFont.systemFontOfSize(11),
            addtag: true,
            target: self,
            action: Selector("menuItemAction:"),
            forControlEvents: UIControlEvents.TouchUpInside,
            backgroundColor: nil,
            imageForNomals: firstImageAr,
            imageForHighlighteds: nil,
            imageForSelecteds: nil,
            parentView: firstPage,
            autoResizeParentView: false)
        
        ///second page
        var secondTitleAr = [String]()
        var secondImageAr = [UIImage]()
        for var i = 8; i < titilAr.count; i++ {
            secondTitleAr.append(titilAr[i])
            secondImageAr.append(imageAr[i])
        }
        
        CreatListViewItemTool.creatListViewItemWith(
            8,
            columns: 4,
            itemSize: CGSizeMake(50, 65),
            xSpace: (self.bounds.width - 50 * 4) / 5,
            ySpace: 10,
            itemTitle: secondTitleAr,
            titleFont: UIFont.systemFontOfSize(11),
            addtag: true,
            target: self,
            action: Selector("menuItemAction:"),
            forControlEvents: UIControlEvents.TouchUpInside,
            backgroundColor: nil,
            imageForNomals: secondImageAr,
            imageForHighlighteds: nil,
            imageForSelecteds: nil,
            parentView: secondPage,
            autoResizeParentView: false)
        
        pageMark = UIPageControl()
        pageMark.numberOfPages = 2
        pageMark.frame = CGRectMake(0, scrollView.extHeight(), SCREENWIDTH, 20)
//        pageMark.backgroundColor = UIColor.whiteColor()
        pageMark.currentPageIndicatorTintColor = THEMECOLOR
        pageMark.pageIndicatorTintColor = UIColor.grayColor()
        self.addSubview(pageMark)

    }
    
    func menuItemAction(item: UIButton) {
        ///do .....
        print(item.tag)
    }
    
    ///UIScroViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
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
