//
//  RootTabBarController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    private let storyboardNameAr = ["Home", "Shop", "Mine", "More"] // "Visit" 已废弃
    private let titleAr = ["首页", "商家", "我的", "更多"]  // "上门" 已废弃
    private let itemIconAr = ["icon_tabbar_homepage",
//        "icon_tabbar_onsite",  // "上门" 已废弃
        "icon_tabbar_merchant_normal",
        "icon_tabbar_mine",
        "icon_tabbar_misc"]
    private let itemSelectedIconAr = ["icon_tabbar_homepage_selected",
//        "icon_tabbar_onsite_selected",  // "上门" 已废弃
        "icon_tabbar_merchant_selected",
        "icon_tabbar_mine_selected",
        "icon_tabbar_misc_selected"]
    
    var barView: UIView!
    var preSelectedBtnTag: Int
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        preSelectedBtnTag = 100
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.addChildViewControllers()
        self.resetTabbar()
        self.creatTabBarItems()
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        preSelectedBtnTag = 100
        super.init(coder: aDecoder)
        self.addChildViewControllers()
        self.resetTabbar()
        self.creatTabBarItems()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
     * 创建自定义可以切换主题的tabbar（覆盖源bar）
     */
    func resetTabbar() {
        for v in (self.tabBar.subviews) {
            v.removeFromSuperview()
        }
        
        barView = UIView(frame: self.tabBar.bounds)
        self.tabBar.addSubview(barView)
    }
    
    /**
     * 创建tabbar上的按钮
     */
    func creatTabBarItems() {
        let btnW = (self.tabBar.bounds.width * 1.0)/(CGFloat)(itemIconAr.count)
        let btnH = self.tabBar.bounds.height
        
        for var i = 0; i < itemIconAr.count; i++ {
            
            let btn = UIButton(frame:CGRectMake(btnW * (CGFloat)(i), 0, btnW, btnH))
            btn.tag = i + 100
            if btn.tag == 100 {
                btn.selected = true
            }
            btn.setImage(UIImage(named: itemIconAr[i]), forState: UIControlState.Normal)
            btn.setImage(UIImage(named: itemSelectedIconAr[i]), forState: UIControlState.Selected)
            btn.addTarget(self, action: Selector("btnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            barView.addSubview(btn)
        }
    }
    
    /**
     * 点击btn的响应方法
     */
    func btnAction(btn: UIButton) {
        if preSelectedBtnTag != btn.tag{
            (barView.viewWithTag(preSelectedBtnTag) as! UIButton).selected = false
            
        }
        /**
        * 根据btn的tag修改显示的视图
        */
        preSelectedBtnTag = btn.tag
        self.selectedIndex = btn.tag - 100;
        btn.selected = true;
    }
    
    /**
     * 添加自控制器
     */
    func addChildViewControllers() {
        var childVCAr = [BaseNavigationController]()
        for var i = 0; i < storyboardNameAr.count; i++ {
            let aName = storyboardNameAr[i] + "Storyboard"
            let aTitle = titleAr[i]
            let nav = self.stupChildViewController(aName, title: aTitle)
            childVCAr.append(nav)
        }
        
        self.viewControllers = childVCAr
    }
    
    /**
     * 创建自控制器
     */
    func stupChildViewController(storyboardName: String, title: String) -> BaseNavigationController{
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()! //sb 可以再加一个NavigationController
        let nav = BaseNavigationController(rootViewController: vc)
        vc.title = title
        return nav
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
