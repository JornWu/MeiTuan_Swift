//
//  ShopViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class ShopViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var segBtn1: UIButton!
    private var segBtn2: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addNavigationItems()
        creatChooseBar()
        creatShopTableView()
    }
    
/****************************************************************************************************/
 /**
 ** 添加导航栏按钮
 **
 */
    private func addNavigationItems() {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        ///map button item
        let lBtn = UIButton(type: UIButtonType.Custom)
        lBtn.frame = CGRectMake(0, 0, 30, 30)
        lBtn.contentMode = UIViewContentMode.ScaleAspectFit
        lBtn.setImage(UIImage(named: "icon_map.png"), forState: UIControlState.Normal)
        lBtn.setImage(UIImage(named: "icon_map_highlighted.png"), forState: UIControlState.Selected)
        lBtn.addTarget(self, action: Selector("openMapView:"), forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem(customView: lBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        ///search button item
        let rBtn = UIButton(type: UIButtonType.Custom)
        rBtn.frame = CGRectMake(0, 0, 30, 30)
        rBtn.contentMode = UIViewContentMode.ScaleAspectFit
        rBtn.setImage(UIImage(named: "icon_search.png"), forState: UIControlState.Normal)
        rBtn.setImage(UIImage(named: "icon_search_selected.png"), forState: UIControlState.Selected)
        rBtn.addTarget(self, action: Selector("openSearchView:"), forControlEvents: UIControlEvents.TouchUpInside)
        let rightItem = UIBarButtonItem(customView: rBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        
        ///segment
        let segView = UIView(frame: CGRectMake(0, 0, 200, 34))
        segView.backgroundColor = UIColor.whiteColor()
        segView.layer.cornerRadius = 5
        segView.layer.borderColor = THEMECOLOR.CGColor
        segView.layer.borderWidth = 2
        
        segBtn1 = UIButton(type: UIButtonType.Custom)
        segBtn1.frame = CGRectMake(0, 2, 100, 30)
        segBtn1.setTitle("全部商家", forState: UIControlState.Normal)
        segBtn1.setTitle("全部商家", forState: UIControlState.Selected)
        segBtn1.selected = true
        segBtn1.tag = 1
//        segBtn1.layer.cornerRadius = 5
//        segBtn1.layer.borderColor = THEMECOLOR.CGColor
//        segBtn1.layer.borderWidth = 2
        segBtn1.titleLabel?.font = UIFont.systemFontOfSize(15)
        segBtn1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        segBtn1.setTitleColor(THEMECOLOR, forState: UIControlState.Normal)
        segBtn1.backgroundColor = THEMECOLOR
        segBtn1.addTarget(self, action: Selector("segBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        segBtn2 = UIButton(type: UIButtonType.Custom)
        segBtn2.frame = CGRectMake(100, 2, 100, 30)
        segBtn2.setTitle("优惠商家", forState: UIControlState.Normal)
        segBtn2.selected = false
        segBtn2.tag = 2
//        segBtn2.layer.cornerRadius = 5
//        btsegBtn2n2.layer.borderColor = THEMECOLOR.CGColor
//        segBtn2.layer.borderWidth = 2
        segBtn2.titleLabel?.font = UIFont.systemFontOfSize(15)
        segBtn2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        segBtn2.setTitleColor(THEMECOLOR, forState: UIControlState.Normal)
        segBtn2.backgroundColor = UIColor.whiteColor()
        segBtn2.addTarget(self, action: Selector("segBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        segView.addSubview(segBtn1)
        segView.addSubview(segBtn2)
        self.navigationItem.titleView = segView
        

//        let backBtn = UIButton(frame: CGRectMake(0, 0, 50, 50))
//        backBtn.setImage(UIImage(named: "back@2x,png"), forState: UIControlState.Normal)
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    func segBtnAction(btn: UIButton)  {
        
        segBtn1.selected = !segBtn1.selected
        if segBtn1.selected {
            segBtn1.backgroundColor = THEMECOLOR
        }else {
            segBtn1.backgroundColor = UIColor.whiteColor()
        }
        
        segBtn2.selected = !segBtn2.selected
        if segBtn2.selected {
            segBtn2.backgroundColor = THEMECOLOR
        }else {
            segBtn2.backgroundColor = UIColor.whiteColor()
        }
        
        if btn.tag == 1 {
            //........ data 1 reload tableview
        }else if btn.tag == 2 {
            //........ data 2 reload tableview
        }
        
    }
    
    
    func openMapView(btn: UIButton) {
        print("open map View")
    }
    
    func openSearchView(btn: UIButton){
        print("open search View")
    }
    
/****************************************************************************************************/
 /**
 ** 下拉选择视图
 **
 */

    func creatChooseBar() {
        
        let chooseBarTopLineView = UIView(frame: CGRectMake(0, 64, SCREENWIDTH, 41))//上分割线，用背景色衬托（多种方法）
        chooseBarTopLineView.backgroundColor = UIColor.grayColor()
        
        let chooseBar = UIView(frame: CGRectMake(0, 1, SCREENWIDTH, 40))
        chooseBar.backgroundColor = UIColor.whiteColor()
        chooseBarTopLineView.addSubview(chooseBar)
        let grayLineView = UIView(frame: CGRectMake(0, 5, SCREENWIDTH, chooseBar.extHeight() - 10))
        grayLineView.backgroundColor = UIColor.grayColor()
        
        self.view.addSubview(chooseBarTopLineView)
        chooseBar.addSubview(grayLineView)
        
        let originTitleAr = ["全部分类", "全城", "智能排序"]
        
        for index in 0 ..< originTitleAr.count {
            let btnItem = UIButton(type: UIButtonType.Custom)
            btnItem.tag = index + 200
            let btnWidth = (SCREENWIDTH - 2) / 3
            btnItem.frame = CGRectMake((btnWidth + 1) * CGFloat(index), 0, btnWidth, chooseBar.extHeight())
            btnItem.setTitle(originTitleAr[index], forState: UIControlState.Normal)
            btnItem.titleLabel?.font = UIFont.systemFontOfSize(13)
            btnItem.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            btnItem.setImage(UIImage(named: "icon_arrow_dropdown_normal"), forState: UIControlState.Normal)
            btnItem.setImage(UIImage(named: "icon_arrow_dropdown_selected"), forState: UIControlState.Selected)
            btnItem.contentMode = UIViewContentMode.ScaleAspectFit
            btnItem.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
            btnItem.imageEdgeInsets = UIEdgeInsetsMake(0, btnItem.extWidth() - 45, 0, 0)
            btnItem.backgroundColor = UIColor.whiteColor()
            btnItem.addTarget(self, action: Selector("creatChooseListView:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            chooseBar.addSubview(btnItem)
        }
    }
    
    
    func creatChooseListView(btn: UIButton) {
        
        if btn.tag == 200 {
            
        }else if btn.tag == 201 {
            
        }else if btn.tag == 202 {
            
        }
        
    }
    
    
/****************************************************************************************************/
 /**
 ** 主tableView
 **
 */
    
    func creatShopTableView() {
        
        let shopTableView = UITableView(frame: CGRectMake(0, 64 + 40, SCREENWIDTH, SCREENHEIGHT - 64 - 40), style: UITableViewStyle.Plain)
        shopTableView.delegate = self
        shopTableView.dataSource = self
        self.view.addSubview(shopTableView)
        
        
        
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ShopCell")
        cell.textLabel!.text = "Jorn Wu"
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
/****************************************************************************************************/
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
