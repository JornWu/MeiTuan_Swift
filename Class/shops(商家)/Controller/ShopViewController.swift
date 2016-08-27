//
//  ShopViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//


import UIKit

protocol ShopViewControllerDelegate: NSObjectProtocol {
    func didClickChoiceBarButtonItemWith(button btn: UIButton)
}

class ShopViewController:BaseViewController,
                         UITableViewDataSource,
                         UITableViewDelegate,
                         ShopDropDownViewControllerDelegate {
    
    var choiceFilterDelegate: ShopViewControllerDelegate! //选择过滤类型的delegate
    
    private var segBtn1: UIButton!
    private var segBtn2: UIButton!
    private var currentSelectedBtnTag: Int!
    
    ///////////////////////////////
    
    private var shopCateListModel: SC_ShopCateListModel!
    private var itemAr = [UIButton]()///用来存储所有选择按钮
    private var currentSelectedItem: UIButton!
    
    private var shopListModel: SP_ShopModel!
    private var kindId: Int64!
    private var shopTableView: UITableView!
    
    private var currentAddressModel: CA_CurrentAddressModel?
    private var headerView: UIView!
    private var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addNavigationItems()
        creatChooseBar()
        
        kindId = -1 ///////
        loadCurrenAddressData()
        loadShopListData(withKindId: kindId)
        loadShopCateListData()
        
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
        let segView = UIView(frame: CGRectMake(0, 0, 200, 30))
        segView.backgroundColor = UIColor.whiteColor()
        segView.layer.borderColor = THEMECOLOR.CGColor
        
        let edge = UIEdgeInsetsMake(10, 5, 10, 5)
            //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
            //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
        var img_1_n = UIImage(named: "btn_banklist_filter_left_normal")
        img_1_n = img_1_n?.resizableImageWithCapInsets(edge, resizingMode: UIImageResizingMode.Stretch)
        var img_1_s = UIImage(named: "btn_banklist_filter_left_selected")
        img_1_s = img_1_s?.resizableImageWithCapInsets(edge, resizingMode: UIImageResizingMode.Stretch)
        
        var img_2_n = UIImage(named: "btn_banklist_filter_right_normal")
        img_2_n = img_2_n?.resizableImageWithCapInsets(edge, resizingMode: UIImageResizingMode.Stretch)
        var img_2_s = UIImage(named: "btn_banklist_filter_right_selected")
        img_2_s = img_2_s?.resizableImageWithCapInsets(edge, resizingMode: UIImageResizingMode.Stretch)
        
        segBtn1 = UIButton(type: UIButtonType.Custom)
        segBtn1.frame = CGRectMake(0, 0, 100, 30)
        segBtn1.setTitle("全部商家", forState: UIControlState.Normal)
        segBtn1.setTitle("全部商家", forState: UIControlState.Selected)
        segBtn1.selected = true
        segBtn1.tag = 1
        segBtn1.titleLabel?.font = UIFont.systemFontOfSize(15)
        segBtn1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        segBtn1.setTitleColor(THEMECOLOR, forState: UIControlState.Normal)
        segBtn1.setBackgroundImage(img_1_n, forState: UIControlState.Normal)
        segBtn1.setBackgroundImage(img_1_s, forState: UIControlState.Selected)
        segBtn1.contentMode = UIViewContentMode.ScaleAspectFill
        segBtn1.addTarget(self, action: Selector("segBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        segBtn2 = UIButton(type: UIButtonType.Custom)
        segBtn2.frame = CGRectMake(100, 0, 100, 30)
        segBtn2.setTitle("优惠商家", forState: UIControlState.Normal)
        segBtn2.selected = false
        segBtn2.tag = 2
        segBtn2.titleLabel?.font = UIFont.systemFontOfSize(15)
        segBtn2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        segBtn2.setTitleColor(THEMECOLOR, forState: UIControlState.Normal)
        segBtn2.setBackgroundImage(img_2_n, forState: UIControlState.Normal)
        segBtn2.setBackgroundImage(img_2_s, forState: UIControlState.Selected)
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
            segBtn2.selected = !segBtn2.selected
  
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
        
        currentSelectedItem = nil
        
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
            
            itemAr.append(btnItem)///放到数组中，统一管理
            
            chooseBar.addSubview(btnItem)
        }
    }
    
    ///控制下拉列表视图的显示
    func chooseListView(btn: UIButton) {
        if currentSelectedItem == nil {
            currentSelectedItem = btn
        }else if currentSelectedItem.tag != btn.tag {//点击另一个按钮
            currentSelectedItem.selected = false
        }
        if (self.choiceFilterDelegate?.respondsToSelector(Selector("didClickChoiceBarButtonItemWith:")) != nil){
            self.choiceFilterDelegate?.didClickChoiceBarButtonItemWith(button: btn)
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
        
        ///加载数据很耗时，放到子线程中
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) { () -> Void in
            NetworkeProcessor.GET(URLString, parameters: nil, progress:
                {
                    [unowned self]
                    (progress: NSProgress) in
                    
                    let activityView = UIActivityIndicatorView(frame: CGRectMake(SCREENWIDTH/2-15, SCREENHEIGHT/2-15, 30, 30))
                    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                    activityView.hidesWhenStopped = true
                    activityView.startAnimating()///转动
                    self.view.addSubview(activityView)
                    self.view.bringSubviewToFront(activityView)
                    
                    if progress.fractionCompleted == 1 {//下载完成
                        activityView.stopAnimating()///停止
                    }
                }, success: {
                    
                [unowned self]//捕获列表，避免循环引用
                (task: NSURLSessionDataTask, responseObject: AnyObject?) in
                //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
                
                ///返回主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.shopCateListModel(withDictionary: responseObject as! NSDictionary)
                })
                
                }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                    print("----获取数据失败----",responseObject)
            })
        }
    }
    
    func shopCateListModel(withDictionary dictionary: NSDictionary) {
        
        self.shopCateListModel = SC_ShopCateListModel(fromDictionary: dictionary)
        
        //self.kindId = shopCateListModel.data[0].mId
        
        //创建分类列表（下拉列表）
        creatFilterTypeChoiceView()
    }
    
    func creatFilterTypeChoiceView() {
        
        let filterTypeChoiceVC = ShopDropDownViewController(withFrame: CGRectMake(0, 64 + 41, SCREENWIDTH, SCREENHEIGHT - 64), shopCateListModel: shopCateListModel)
        self.choiceFilterDelegate = filterTypeChoiceVC
        filterTypeChoiceVC.delegate = self//注意循环引用
        self.view.insertSubview(filterTypeChoiceVC.view, atIndex: 1)///在主白视图之上就行
        
    }
    
    ///ShopDropDownViewDelegate
    func didChoosedFilterType(kindId: Int) {
        self.kindId = Int64(kindId)
        self.loadShopListData(withKindId: self.kindId)///重新加载数据
    }
    
    ///ShopDropDownViewDelegate
    func didChoosedSortType() {
        //doing
    }
    
    //////ShopDropDownViewDelegate
    func didRevertDropDownViewState() {
        for index in itemAr {
            index.selected = false ///恢复左右按钮的状态
        }
    }
    
    
/****************************************************************************************************/
 /**
 ** 主tableView
 **
 */

/*
系统同时提供了几种并发队列。这些队列和它们自身的QoS等级相关。QoS等级表示了提交任务的意图，使得GCD可以决定如何制定优先级。

QOS_CLASS_USER_INTERACTIVE： user interactive 等级表示任务需要被立即执行以提供好的用户体验。使用它来更新UI，
                            响应事件以及需要低延时的小工作量任务。这个等级的工作总量应该保持较小规模。
QOS_CLASS_USER_INITIATED：   user initiated 等级表示任务由UI发起并且可以异步执行。它应该用在用户需要即时
                            的结果同时又要求可以继续交互的任务。
QOS_CLASS_UTILITY：         utility 等级表示需要长时间运行的任务，常常伴随有用户可见的进度指示器。
                            使用它来做计算，I/O，网络，持续的数据填充等任务。这个等级被设计成节能的。
QOS_CLASS_BACKGROUND：       background 等级表示那些用户不会察觉的任务。使用它来执行预加载，
                            维护或是其它不需用户交互和对时间不敏感的任务。
*/
    func loadCurrenAddressData() {
        let URLString = UrlStrType.Address.getUrlString()
        
        ///加载数据很耗时，放到子线程中
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) { () -> Void in
            NetworkeProcessor.GET(URLString, parameters: nil, progress: {
                [unowned self]
                (progress: NSProgress) in
                
                let activityView = UIActivityIndicatorView(frame: CGRectMake(SCREENWIDTH / 2 - 15, SCREENHEIGHT / 2 - 15, 30, 30))
                activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                activityView.hidesWhenStopped = true
                activityView.startAnimating()///转动
                self.view.addSubview(activityView)
                self.view.bringSubviewToFront(activityView)
                
                if progress.fractionCompleted == 1 {//下载完成
                    activityView.stopAnimating()///停止
                }
                
                }, success: {
                    [unowned self]//捕获列表，避免循环引用
                    (task: NSURLSessionDataTask, responseObject: AnyObject?) in
                    //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
                    
                    ///返回主线程刷新UI
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.currentAddressModel(withDictionary: responseObject as! NSDictionary)
                    })
                    
                }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                    print("----获取数据失败----",responseObject)
            })
        }

    }
    
    func currentAddressModel(withDictionary dictionary: NSDictionary) {
        currentAddressModel = CA_CurrentAddressModel(fromDictionary: dictionary)
        
        if headerView == nil {
            creatheaderView()
        }else {
            if currentAddressModel != nil {
                let dataModel = currentAddressModel!.data
                addressLabel.text = "当前位置：" + dataModel.province + dataModel.city + dataModel.district + dataModel.detail
            }else {
                addressLabel.text = "无法获取当前地址，请检查GPS是否打开或者网络是否打开。"
            }
        }
    }
    
    func creatheaderView() {
        headerView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 30))
        addressLabel = UILabel(frame: CGRectMake(0, 0, headerView.extWidth() - 30, 30))
        addressLabel.font = UIFont.systemFontOfSize(13)
        headerView.addSubview(addressLabel)
        
        let refreshBtn = UIButton(frame: CGRectMake(addressLabel.extWidth(), 5, 20, 20))
        refreshBtn.setImage(UIImage(named: "icon_dellist_locate_refresh"), forState: UIControlState.Normal)
        refreshBtn.contentMode = UIViewContentMode.ScaleAspectFit
        headerView.addSubview(refreshBtn)
        refreshBtn.addTarget(self, action: Selector("refreshAddressInfo"), forControlEvents: UIControlEvents.TouchUpInside)
        
        if currentAddressModel != nil {
            let dataModel = currentAddressModel!.data
            addressLabel.text = "当前位置：" + dataModel.province + dataModel.city + dataModel.district + dataModel.detail
        }else {
            addressLabel.text = "无法获取当前地址，请检查GPS是否打开或者网络是否打开。"
        }
    }
    
    func refreshAddressInfo() {
        loadCurrenAddressData()//重新加载
    }
    
    ///商家列表数据
    func loadShopListData(withKindId kId: Int64) {
        let URLString = UrlStrType.urlStringWithMerchantStr(kId, offset: 10)
        
        ///加载数据很耗时，放到子线程中
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) { () -> Void in
            NetworkeProcessor.GET(URLString, parameters: nil, progress: {
                [unowned self]
                (progress: NSProgress) in
                
                let activityView = UIActivityIndicatorView(frame: CGRectMake(SCREENWIDTH/2-15, SCREENHEIGHT/2-15, 30, 30))
                activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                activityView.hidesWhenStopped = true
                activityView.startAnimating()///转动
                self.view.addSubview(activityView)
                self.view.bringSubviewToFront(activityView)
                
                if progress.fractionCompleted == 1 {//下载完成
                    activityView.stopAnimating()///停止
                }
                
                }, success: {
                    
                [unowned self]//捕获列表，避免循环引用
                (task: NSURLSessionDataTask, responseObject: AnyObject?) in
                //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
                
                ///返回主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.shopListModel(withDictionary: responseObject as! NSDictionary)
                })
                
                }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                    print("----获取数据失败----",responseObject)
            })
        }

    }
    
    func shopListModel(withDictionary dictionary: NSDictionary) {
        self.shopListModel = SP_ShopModel(fromDictionary: dictionary)
        if (shopTableView != nil) {///如果不为nil从新加载数据就好了
            self.shopTableView.reloadData()//刷新表格
        }else {
            creatShopTableView()//先加载好数据再创建表格，因为数据是异步加载和在子线程中加载，先创建表格会产生错误，因为还没有数据
        }
    }
    
    
    func creatShopTableView() {
        
        shopTableView = UITableView(frame: CGRectMake(0, 64 + 41 + 1, SCREENWIDTH, SCREENHEIGHT - 64 - 42 - 49), style: UITableViewStyle.Plain)
        shopTableView.tag = 304
        shopTableView.backgroundColor = BACKGROUNDCOLOR
        shopTableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0)
        shopTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        shopTableView.delegate = self
        shopTableView.dataSource = self
        
        shopTableView.tableHeaderView = headerView///确保headernView先创建
        
        shopTableView.registerNib(UINib(nibName: "ShopTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopCell")
        
        self.view.insertSubview(shopTableView, atIndex: 0)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopListModel.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ShopTableViewCell.creatCellWithTableView(tableView, reuseIdentify: "ShopCell", indexPath: indexPath)
        let dataMode = shopListModel.data[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.mImageView.sd_setImageWithURL(NSURL(string: dataMode.frontImg), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
        cell.titleBL.text = dataMode.name
        cell.subTitle.text = dataMode.cateName + " " + dataMode.areaName
        cell.subTitle.textColor = UIColor.grayColor()
        
        ///临时处理
        if dataMode.markNumbers != nil {
        cell.evaluateLB.text = "\(dataMode.markNumbers)" + "评价"
        }else {
            cell.evaluateLB.hidden = true
        }
        
        if dataMode.avgPrice != nil {
        cell.priceLB.text = "人均" + "\(dataMode.avgPrice)"
        }else {
            cell.priceLB.hidden = true
        }
        
        cell.dictanceLB.hidden = true
        
        if dataMode.hasGroup! {
            cell.markImageView1.image = UIImage(named: "icon_merchant_mark_tuan")
        }
        if dataMode.isWaimai! != 0 {
            cell.markImageView2.image = UIImage(named: "icon_merchant_mark_waimai")
        }
        if dataMode.discount != nil {
            cell.markImageVIew3.image = UIImage(named: "icon_merchant_mark_paybill")
        }else if dataMode.isQueuing! != 0 {
            cell.markImageVIew3.image = UIImage(named: "icon_merchant_mark_queque")
        }
        
        //cell.setNeedsLayout()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
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
