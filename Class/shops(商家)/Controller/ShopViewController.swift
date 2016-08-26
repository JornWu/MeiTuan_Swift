//
//  ShopViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//


import UIKit

protocol ShopViewControllerDelegate: NSObjectProtocol {
    func didClickChoiceBarButtonItemWith(tag t: Int)
    func didChoiceTheTypeWith(id mId: Int64)
}

class ShopViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, ShopDropDownViewDelegate {
    
    weak var choiceFilterDelegate: ShopViewControllerDelegate? //选择过滤类型的delegate
    
    private var segBtn1: UIButton!
    private var segBtn2: UIButton!
    private var currentSelectedBtnTag: Int!
    
    ///////////////////////////////
    
    private var shopCateListModel: SC_ShopCateListModel!
    private var shopListModel: SP_ShopModel!
    private var kindId: Int64!
    private var shopTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNavigationItems()
        
        //loadShopCateListData()
        
        kindId = -1 ///////
        loadShopListData(withKindId: kindId)
        
        creatChooseBar()
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
        segBtn1.frame = CGRectMake(0, 1, 100, 32)
        segBtn1.setTitle("全部商家", forState: UIControlState.Normal)
        segBtn1.setTitle("全部商家", forState: UIControlState.Selected)
        segBtn1.selected = true
        segBtn1.tag = 1
        segBtn1.layer.cornerRadius = 5
//        segBtn1.layer.borderColor = THEMECOLOR.CGColor
//        segBtn1.layer.borderWidth = 2
        segBtn1.titleLabel?.font = UIFont.systemFontOfSize(15)
        segBtn1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        segBtn1.setTitleColor(THEMECOLOR, forState: UIControlState.Normal)
        segBtn1.backgroundColor = THEMECOLOR
        segBtn1.addTarget(self, action: Selector("segBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        segBtn2 = UIButton(type: UIButtonType.Custom)
        segBtn2.frame = CGRectMake(100, 1, 100, 32)
        segBtn2.setTitle("优惠商家", forState: UIControlState.Normal)
        segBtn2.selected = false
        segBtn2.tag = 2
        segBtn2.layer.cornerRadius = 5
//        btsegBtn2n2.layer.borderColor = THEMECOLOR.CGColor
//        segBtn2.layer.borderWidth = 2
        segBtn2.titleLabel?.font = UIFont.systemFontOfSize(15)
        segBtn2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        segBtn2.setTitleColor(THEMECOLOR, forState: UIControlState.Normal)
        segBtn2.backgroundColor = UIColor.whiteColor()
        segBtn2.addTarget(self, action: Selector("segBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        currentSelectedBtnTag = 1 //segBtn1
        segView.addSubview(segBtn1)
        segView.addSubview(segBtn2)
        self.navigationItem.titleView = segView
        

    }
    
    func segBtnAction(btn: UIButton)  {
        if btn.tag != currentSelectedBtnTag {//不是原来的button
            currentSelectedBtnTag = btn.tag
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
        
    }
    
    
    func openMapView(btn: UIButton) {
        print("open map View")
    }
    
    func openSearchView(btn: UIButton){
        let SHVC = SearchViewController()
        self.navigationController?.pushViewController(SHVC, animated: true)

    }
    
/****************************************************************************************************/
 /**
 ** 下拉类型选择视图
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
            btnItem.addTarget(self, action: Selector("chooseListView:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            chooseBar.addSubview(btnItem)
        }
    }
    
    ///控制下拉列表视图的显示
    func chooseListView(btn: UIButton) {
        
        if (self.choiceFilterDelegate?.respondsToSelector(Selector("didClickChoiceBarButtonItemWith:")) != nil){
            self.choiceFilterDelegate?.didClickChoiceBarButtonItemWith(tag: btn.tag)
        }
        
    }
    
    
/****************************************************************************************************/
 /**
 ** 下拉视图
 **
 */
    ///商家分类列表数据
    func loadShopCateListData() {
        let URLString = UrlStrType.CateList.getUrlString()
        NetworkeProcessor.GET(URLString, parameters: nil, progress: nil, success: {
            [unowned self]//捕获列表，避免循环引用
            (task: NSURLSessionDataTask, responseObject: AnyObject?) in
            //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了

            self.shopCateListModel(withDictionary: responseObject as! NSDictionary)
            
            }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                print("----获取数据失败----",responseObject)
        })
    }
    
    func shopCateListModel(withDictionary dictionary: NSDictionary) {
        
        self.shopCateListModel = SC_ShopCateListModel(fromDictionary: dictionary)
        
        //self.kindId = shopCateListModel.data[0].mId
        
        //创建分类列表（下拉列表）
        creatFilterTypeChoiceView()
    }
    
    func creatFilterTypeChoiceView() {
        
        let filterTypeChoiceView = ShopDropDownView(frame: CGRectMake(0, 64 + 41, SCREENWIDTH, SCREENHEIGHT - 64), shopCateListModel: shopCateListModel)
        self.choiceFilterDelegate = filterTypeChoiceView
        filterTypeChoiceView.delegate = self//注意循环引用
        self.view.addSubview(filterTypeChoiceView)
        
    }
    
    ///ShopDropDownViewDelegate
    func didChoosedFilterType(kindId: Int64) {
        self.kindId = kindId
        self.loadShopListData(withKindId: self.kindId)
        self.shopTableView.reloadData()//重新加载数据
    }
    
    ///ShopDropDownViewDelegate
    func didChoosedSortType() {
        //doing
    }
    
    
/****************************************************************************************************/
 /**
 ** 主tableView
 **
 */
    
    ///商家列表数据
    func loadShopListData(withKindId kId: Int64) {
        let URLString = UrlStrType.urlStringWithMerchantStr(kId, offset: 10)
        NetworkeProcessor.GET(URLString, parameters: nil, progress: nil, success: {
            [unowned self]//捕获列表，避免循环引用
            (task: NSURLSessionDataTask, responseObject: AnyObject?) in
            //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
            
            self.shopCateListModel(withDictionary: responseObject as! NSDictionary)
            
            }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                print("----获取数据失败----",responseObject)
        })
    }
    
    func shopListModel(withDictionary dictionary: NSDictionary) {
        self.shopListModel = SP_ShopModel(fromDictionary: dictionary)
        creatShopTableView()//先加载好数据再创建表格，因为数据是异步加载和在子线程中加载，先创建表格会产生错误，因为还没有数据
    }
    
    
    func creatShopTableView() {
        
        shopTableView = UITableView(frame: CGRectMake(0, 64 + 40, SCREENWIDTH, SCREENHEIGHT - 64 - 40), style: UITableViewStyle.Plain)
        shopTableView.tag = 304
        shopTableView.backgroundColor = BACKGROUNDCOLOR
        shopTableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0)
        shopTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        shopTableView.delegate = self
        shopTableView.dataSource = self
        
        shopTableView.registerNib(UINib(nibName: "ShopTableViewCell.xib", bundle: nil), forCellReuseIdentifier: "ShopCell")
        
        self.view.addSubview(shopTableView)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopListModel.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dataMode = shopListModel.data[indexPath.row]
        let cell = ShopTableViewCell.creatCellWithTableView(tableView, reuseIdentify: "ShopCell", indexPath: indexPath)
        cell.imageView?.sd_setImageWithURL(NSURL(string: dataMode.frontImg), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
        cell.titleBL.text = dataMode.name
        cell.subTitle.text = dataMode.cateName + " " + dataMode.areaName
        cell.subTitle.textColor = UIColor.grayColor()
        cell.evaluateLB.text = "\(dataMode.markNumbers)" + "评价"
        cell.priceLB.text = "人均" + "\(dataMode.avgPrice)"
        
        if dataMode.hasGroup! {
            cell.markImageView1.image = UIImage(named: "icon_merchant_mark_tuan")
        }else if dataMode.isWaimai! != 0 {
            cell.markImageView1.image = UIImage(named: "icon_merchant_mark_waimai")
        }
        
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
