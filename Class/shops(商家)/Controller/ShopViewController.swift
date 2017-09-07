//
//  ShopViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//


import UIKit

@objc protocol ShopViewControllerDelegate: NSObjectProtocol {
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
    
    ///
    private var preferentialView: UIView!
    
    ///////////////////////////////
    
    private var shopCateListModel: SC_ShopCateListModel!
    private var itemAr = [UIButton]()///用来存储所有选择按钮
    private var currentSelectedItem: UIButton!
    
    private var shopListModel: SP_ShopModel!///商家列表数据
    private var kindId: Int64!
    private var kindName: String!
    private var shopTableView: UITableView!
    
    private var isRefresh = false
    private var offset: Int64 = 0
    
    private var currentAddressModel: CA_CurrentAddressModel?
    private var headerView: UIView!
    private var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addNavigationItems()
        creatPreferentialView()///test
        creatChooseBar()
        
        kindId = -1 ///////
        loadCurrenAddressData()
        loadShopListData(withKindId: kindId)
        loadShopCateListData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.barTintColor = UIColor.white
        self.navigationController!.navigationBar.isHidden = false
    }
    
/****************************************************************************************************/
 /**
 ** 添加导航栏按钮
 **
 */
    private func addNavigationItems() {
        ///map button item
        let lBtn = UIButton(type: UIButtonType.custom)
        lBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        lBtn.contentMode = UIViewContentMode.scaleAspectFit
        lBtn.setImage(UIImage(named: "icon_map.png"), for: UIControlState())
        lBtn.setImage(UIImage(named: "icon_map_highlighted.png"), for: UIControlState.selected)
        lBtn.addTarget(self, action: #selector(ShopViewController.openMapView(_:)), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem(customView: lBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        ///search button item
        let rBtn = UIButton(type: UIButtonType.custom)
        rBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        rBtn.contentMode = UIViewContentMode.scaleAspectFit
        rBtn.setImage(UIImage(named: "icon_search.png"), for: UIControlState())
        rBtn.setImage(UIImage(named: "icon_search_selected.png"), for: UIControlState.selected)
        rBtn.addTarget(self, action: #selector(ShopViewController.openSearchView(_:)), for: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem(customView: rBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        
        ///segment
        let segView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        segView.backgroundColor = UIColor.white
        segView.layer.borderColor = THEMECOLOR.cgColor
        
        let edge = UIEdgeInsetsMake(10, 5, 10, 5)
            //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
            //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
        var img_1_n = UIImage(named: "btn_banklist_filter_left_normal")
        img_1_n = img_1_n?.resizableImage(withCapInsets: edge, resizingMode: UIImageResizingMode.stretch)
        var img_1_s = UIImage(named: "btn_banklist_filter_left_selected")
        img_1_s = img_1_s?.resizableImage(withCapInsets: edge, resizingMode: UIImageResizingMode.stretch)
        
        var img_2_n = UIImage(named: "btn_banklist_filter_right_normal")
        img_2_n = img_2_n?.resizableImage(withCapInsets: edge, resizingMode: UIImageResizingMode.stretch)
        var img_2_s = UIImage(named: "btn_banklist_filter_right_selected")
        img_2_s = img_2_s?.resizableImage(withCapInsets: edge, resizingMode: UIImageResizingMode.stretch)
        
        segBtn1 = UIButton(type: UIButtonType.custom)
        segBtn1.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        segBtn1.setTitle("全部商家", for: UIControlState())
        segBtn1.setTitle("全部商家", for: UIControlState.selected)
        segBtn1.isSelected = true
        segBtn1.tag = 1
        segBtn1.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        segBtn1.setTitleColor(UIColor.white, for: UIControlState.selected)
        segBtn1.setTitleColor(THEMECOLOR, for: UIControlState())
        segBtn1.setBackgroundImage(img_1_n, for: UIControlState())
        segBtn1.setBackgroundImage(img_1_s, for: UIControlState.selected)
        segBtn1.contentMode = UIViewContentMode.scaleAspectFill
        segBtn1.addTarget(self, action: #selector(ShopViewController.segBtnAction(_:)), for: UIControlEvents.touchUpInside)
        
        segBtn2 = UIButton(type: UIButtonType.custom)
        segBtn2.frame = CGRect(x: 100, y: 0, width: 100, height: 30)
        segBtn2.setTitle("优惠商家", for: UIControlState())
        segBtn2.isSelected = false
        segBtn2.tag = 2
        segBtn2.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        segBtn2.setTitleColor(UIColor.white, for: UIControlState.selected)
        segBtn2.setTitleColor(THEMECOLOR, for: UIControlState())
        segBtn2.setBackgroundImage(img_2_n, for: UIControlState())
        segBtn2.setBackgroundImage(img_2_s, for: UIControlState.selected)
        segBtn2.addTarget(self, action: #selector(ShopViewController.segBtnAction(_:)), for: UIControlEvents.touchUpInside)
        
        currentSelectedBtnTag = 1 //segBtn1
        segView.addSubview(segBtn1)
        segView.addSubview(segBtn2)
        self.navigationItem.titleView = segView
        

    }
    
    func segBtnAction(_ btn: UIButton)  {
        if btn.tag != currentSelectedBtnTag {//不是原来的button
            currentSelectedBtnTag = btn.tag
            segBtn1.isSelected = !segBtn1.isSelected
            segBtn2.isSelected = !segBtn2.isSelected
  
            if btn.tag == 1 {
                //........ data 1 reload tableview
                
                UIView.transition(with: self.view, duration: 2, options: UIViewAnimationOptions.transitionCurlDown, animations: {
                    [unowned self]
                    () -> Void in
                    self.shopTableView.isHidden = false
                    self.preferentialView.isHidden = true
                    }, completion: { (isCompletion) -> Void in
                        if isCompletion {
                            ///doing
                        }
                })
                
                ///test
                //UIView.transitionFromView(shopTableView, toView: preferentialView, duration: 0.5, options: UIViewAnimationOptions.CurveEaseIn, completion: nil)
            }else if btn.tag == 2 {
                //........ data 2 reload tableview
                ///test
                
                UIView.transition(with: self.view, duration: 2, options: UIViewAnimationOptions.transitionCurlUp, animations: {
                    [unowned self]
                    () -> Void in
                    self.shopTableView.isHidden = true
                    self.preferentialView.isHidden = false
                    }, completion: { (isCompletion) -> Void in
                        if isCompletion {
                            ///doing
                        }
                })
                //UIView.transitionFromView(preferentialView, toView: shopTableView, duration: 0.5, options: UIViewAnimationOptions.CurveEaseOut, completion: nil)
            }
        }
        
    }
    
    ///test ///优惠商家
    func creatPreferentialView() {
        preferentialView = UIView(frame: CGRect(x: 0, y: 105, width: SCREENWIDTH,height: SCREENHEIGHT - 41 - 64))
        preferentialView.backgroundColor = THEMECOLOR
        let imageView = UIImageView(frame: preferentialView.bounds)
        imageView.image = UIImage(named: "icon_menu.jpg")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        preferentialView.addSubview(imageView)
        preferentialView.isHidden = true
        self.view.addSubview(preferentialView)
    }
    
    
    func openMapView(_ btn: UIButton) {
        
        let mapVC = MapViewController()
        if self.kindName == nil {
            mapVC.kindName = "全部分类"
        }else {
            mapVC.kindName = self.kindName
        }
        
        if self.kindId == nil {
            mapVC.kindId = -1
        }else {
            mapVC.kindId = self.kindId
        }
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mapVC, animated: true)
        self.hidesBottomBarWhenPushed = false
        
    }
    
    func openSearchView(_ btn: UIButton){
        let SHVC = SearchViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(SHVC, animated: true)
        self.hidesBottomBarWhenPushed = false

    }
    
/****************************************************************************************************/
 /**
 ** 下拉类型选择视图
 **
 */

    func creatChooseBar() {
        
        let chooseBarTopLineView = UIView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: 41))//上分割线，用背景色衬托（多种方法）
        chooseBarTopLineView.backgroundColor = UIColor.gray
        
        let chooseBar = UIView(frame: CGRect(x: 0, y: 1, width: SCREENWIDTH, height: 40))
        chooseBar.backgroundColor = UIColor.white
        chooseBarTopLineView.addSubview(chooseBar)
        let grayLineView = UIView(frame: CGRect(x: 0, y: 5, width: SCREENWIDTH, height: chooseBar.extHeight() - 10))
        grayLineView.backgroundColor = UIColor.gray
        
        self.view.addSubview(chooseBarTopLineView)
        chooseBar.addSubview(grayLineView)
        
        currentSelectedItem = nil
        
        let originTitleAr = ["全部分类", "全城", "智能排序"]
        
        for index in 0 ..< originTitleAr.count {///这里btnItem类建议自定义，要不图片和文字位置不好控制
            let btnItem = UIButton(type: UIButtonType.custom)
            btnItem.tag = index + 200
            let btnWidth = (SCREENWIDTH - 2) / 3
            btnItem.frame = CGRect(x: (btnWidth + 1) * CGFloat(index), y: 0, width: btnWidth, height: chooseBar.extHeight())
            btnItem.setTitle(originTitleAr[index], for: UIControlState())
            btnItem.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btnItem.setTitleColor(UIColor.gray, for: UIControlState())
            btnItem.setImage(UIImage(named: "icon_arrow_dropdown_normal"), for: UIControlState())
            btnItem.setImage(UIImage(named: "icon_arrow_dropdown_selected"), for: UIControlState.selected)
            btnItem.contentMode = UIViewContentMode.scaleAspectFit
            btnItem.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
            
            btnItem.imageEdgeInsets = UIEdgeInsetsMake(0, btnItem.extWidth() - 20, 0, 0)
            btnItem.backgroundColor = UIColor.white
            btnItem.addTarget(self, action: #selector(ShopViewController.chooseListView(_:)), for: UIControlEvents.touchUpInside)
            
            
            itemAr.append(btnItem)///放到数组中，统一管理
            
            chooseBar.addSubview(btnItem)
        }
    }
    
    ///控制下拉列表视图的显示
    func chooseListView(_ btn: UIButton) {
        if currentSelectedItem == nil {
            currentSelectedItem = btn
        }else if currentSelectedItem.tag != btn.tag {//点击另一个按钮
            currentSelectedItem.isSelected = false
        }
        if (self.choiceFilterDelegate?.responds(to: #selector(ShopViewControllerDelegate.didClickChoiceBarButtonItemWith(button:))) != nil){
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

        self.view.bringSubview(toFront: self.activityIndicatorView)///放在最上面
        self.activityIndicatorView.isHidden = false ///让activityView显示
        
        let URLString = UrlStrType.cateList.getUrlString()
        ///封装的方法
        NetworkeProcessor.loadNetworkeDate(withTarget: self, URLString: URLString) {
            [unowned self]
            (dictionary) in
            self.shopCateListModel(withDictionary: dictionary)
            self.activityIndicatorView.isHidden = true ///让activityView隐藏
        }

    }
    
    func shopCateListModel(withDictionary dictionary: NSDictionary) {
        
        self.shopCateListModel = SC_ShopCateListModel(fromDictionary: dictionary)
        
        //创建分类列表（下拉列表）
        creatFilterTypeChoiceView()
    }
    
    func creatFilterTypeChoiceView() {
        
        let filterTypeChoiceVC = ShopDropDownViewController(withFrame: CGRect(x: 0, y: 64 + 41, width: SCREENWIDTH, height: SCREENHEIGHT - 64), shopCateListModel: shopCateListModel)
        self.choiceFilterDelegate = filterTypeChoiceVC
        filterTypeChoiceVC.delegate = self//注意循环引用
        self.view.insertSubview(filterTypeChoiceVC.view, at: 1)///在主白视图之上就行
        
    }
    
    ///ShopDropDownViewDelegate
    func didChoosedFilterType(_ kindId: Int, kindName: String) {
        self.kindId = Int64(kindId)
        self.kindName = kindName
        self.loadShopListData(withKindId: self.kindId)///重新加载数据
    }
    
    ///ShopDropDownViewDelegate
    func didChoosedSortType() {
        //doing
    }
    
    ///ShopDropDownViewDelegate
    func didRevertDropDownViewState() {
        for index in itemAr {
            index.isSelected = false ///恢复左右按钮的状态
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
        let URLString = UrlStrType.address.getUrlString()
     
        ///未封装方法
//        ///加载数据很耗时，放到子线程中
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) { () -> Void in
//            NetworkeProcessor.GET(URLString, parameters: nil, progress: {
//                [unowned self]
//                (progress: NSProgress) in
//                ///要用KVO监视progress的进度可以在这里添加
//                let activityView = UIActivityIndicatorView(frame: CGRectMake(SCREENWIDTH / 2 - 15, SCREENHEIGHT / 2 - 15, 30, 30))
//                activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//                activityView.hidesWhenStopped = true
//                activityView.startAnimating()///转动
//                self.view.addSubview(activityView)
//                self.view.bringSubviewToFront(activityView)
//                
//                if progress.fractionCompleted == 1 {//下载完成
//                    activityView.stopAnimating()///停止
//                }
//                
//                }, success: {
//                    [unowned self]//捕获列表，避免循环引用
//                    (task: NSURLSessionDataTask, responseObject: AnyObject?) in
//                    //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
//                    
//                    ///返回主线程刷新UI
//                    dispatch_async(dispatch_get_main_queue(), {
//                        [unowned self]
//                        () -> Void in
//                        self.currentAddressModel(withDictionary: responseObject as! NSDictionary)
//                    })
//                    
//                }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
//                    print("----获取数据失败----",responseObject)
//            })
//        }
        
        ///封装的方法
        NetworkeProcessor.loadNetworkeDate(withTarget: self, URLString: URLString) {
            [unowned self]
            (dictionary) in
            self.currentAddressModel(withDictionary: dictionary)
        }

    }
    
    func currentAddressModel(withDictionary dictionary: NSDictionary) {
        currentAddressModel = CA_CurrentAddressModel(fromDictionary: dictionary)
        
        if headerView == nil {
            creatheaderView()
        }else {
            if currentAddressModel != nil {
                let dataModel = currentAddressModel!.data
                addressLabel.text = "当前位置：" + dataModel!.province + dataModel!.city + dataModel!.district + dataModel!.detail
            }else {
                addressLabel.text = "无法获取当前地址，请检查GPS是否打开或者网络是否打开。"
            }
        }
    }
    
    func creatheaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 30))
        addressLabel = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.extWidth() - 30, height: 30))
        addressLabel.font = UIFont.systemFont(ofSize: 13)
        headerView.addSubview(addressLabel)
        
        let refreshBtn = UIButton(frame: CGRect(x: addressLabel.extWidth(), y: 5, width: 20, height: 20))
        refreshBtn.setImage(UIImage(named: "icon_dellist_locate_refresh"), for: UIControlState())
        refreshBtn.contentMode = UIViewContentMode.scaleAspectFit
        headerView.addSubview(refreshBtn)
        refreshBtn.addTarget(self, action: #selector(ShopViewController.refreshAddressInfo), for: UIControlEvents.touchUpInside)
        
        if currentAddressModel != nil {
            let dataModel = currentAddressModel!.data
            addressLabel.text = "当前位置：" + dataModel!.province + dataModel!.city + dataModel!.district + dataModel!.detail
        }else {
            addressLabel.text = "无法获取当前地址，请检查GPS是否打开或者网络是否打开。"
        }
    }
    
    func refreshAddressInfo() {
        loadCurrenAddressData()//重新加载
    }
    
    ///商家列表数据
    func loadShopListData(withKindId kId: Int64) {
        self.view.bringSubview(toFront: self.activityIndicatorView)
        self.activityIndicatorView.isHidden = false ///让activityView显示
        let URLString = UrlStrType.urlStringWithMerchantStr(kId, offset: 10)
        ///封装的方法
        NetworkeProcessor.loadNetworkeDate(withTarget: self, URLString: URLString) {
            [unowned self]
            (dictionary) in
            self.shopListModel(withDictionary: dictionary)
            self.activityIndicatorView.isHidden = true ///让activityView隐藏
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
        
        shopTableView = UITableView(frame: CGRect(x: 0, y: 64 + 41 + 1, width: SCREENWIDTH, height: SCREENHEIGHT - 64 - 42 - 49), style: UITableViewStyle.plain)
        shopTableView.tag = 304
        shopTableView.backgroundColor = BACKGROUNDCOLOR
        shopTableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0)
        shopTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        shopTableView.delegate = self
        shopTableView.dataSource = self
        
        shopTableView.tableHeaderView = headerView///确保headernView先创建
        
        addRefreshView()///添加刷新视图
        
        shopTableView.register(UINib(nibName: "ShopTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopCell")
        
        self.view.insertSubview(shopTableView, at: 0)///放在最下面
        
    }
    
    
    func addRefreshView() {///添加刷新视图
        
        ///refresh视图
        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))!
        
        ///设置普通状态的动画图片
        var idleImages = [UIImage]() ///创建数字对象
        for i in 1 ... 60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            idleImages.append(image!)
        }
        
        header.setImages(idleImages, for: .idle)
        
        //设置即将刷新状态的动画图片
        var refreshingImages = [UIImage]()
        for i in 1 ... 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshingImages.append(image!)
        }
        
        header.setImages(idleImages, for: .idle)///正常
        header.setImages(refreshingImages, for: .pulling)///下拉过程
        header.setImages(refreshingImages, for: .refreshing)///刷新过程
        
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("释放开始刷新", for: .pulling)
        header.setTitle("正在刷新数据中...", for: .refreshing)
        
        shopTableView.mj_header = header
        
        let footer = MJRefreshAutoGifFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        footer?.setImages(refreshingImages, for: .refreshing)///加载过程
        shopTableView.mj_footer = footer
    }
    
    ///下拉刷新
    func loadNewData() {
        
        ///直接调用上面的代码重新获取新数据
        isRefresh = true
        
        loadShopListData(withKindId: kindId)///注意新的数量（在此忽略了）
        self.shopTableView.mj_header.endRefreshing()
    }
    
    ///上拉加载
    func loadMoreData() {
        offset += 10///每次上来添加10条 (10为每次请求的数量，在此为测试值)
        
        ///新建一个缓冲数组接受新数据，然后再添加到原数组后面，然后再reload表格（因接口原因，在此没法实现了）
        
        let URLString = UrlStrType.urlStringWithMerchantStr(kindId, offset: offset)
        ///封装的方法
        NetworkeProcessor.loadNetworkeDate(withTarget: self, URLString: URLString) {
            [unowned self]
            (dictionary) in
            
            self.isRefresh = true
            let newModel = SP_ShopModel(fromDictionary: dictionary) ///新的数据
            
            /* ///SP_ShopModel
            var count : Int!
            var ctPoi : String!
            var ctPois : [SP_CtPoi]!
            var data : [SP_Data]!
            var serverInfo : SP_ServerInfo!
            */
            
            ///把新的数据添加到原数据的后面
            self.shopListModel.data.append(contentsOf: newModel.data)
            self.shopListModel.ctPois.append(contentsOf: newModel.ctPois)
            self.shopListModel.count! += newModel.count!
            
            self.shopTableView.mj_footer.endRefreshing()
            self.shopTableView.reloadData()///刷新表格数据
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopListModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShopTableViewCell.creatCellWithTableView(tableView, reuseIdentify: "ShopCell", indexPath: indexPath)
        
        let dataModel = shopListModel.data[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.mImageView.sd_setImage(with: URL(string: dataModel.frontImg), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
        cell.titleBL.text = dataModel.name
        cell.subTitle.text = dataModel.cateName + " " + dataModel.areaName
        cell.subTitle.textColor = UIColor.gray
        
        let starView = StarView(withRate: CGFloat(dataModel.avgScore), total: 5, starWH: 20, space: 1,starImageFull: UIImage(named: "icon_merchant_star_full")!, starImageEmpty: UIImage(named: "icon_merchant_star_empty")!)
        
        cell.ratingView.addSubview(starView)
        
        ///临时处理
        if dataModel.markNumbers != nil {
        cell.evaluateLB.text = "\(dataModel.markNumbers!)" + "评价"
        }else {
            cell.evaluateLB.isHidden = true
        }
        
        if dataModel.avgPrice != nil {
        cell.priceLB.text = "人均" + "\(dataModel.avgPrice!)"
        }else {
            cell.priceLB.isHidden = true
        }
        
        cell.dictanceLB.isHidden = true
        
        if dataModel.hasGroup! {
            cell.markImageView1.image = UIImage(named: "icon_merchant_mark_tuan")
        }
        if dataModel.isWaimai! != 0 {
            cell.markImageView2.image = UIImage(named: "icon_merchant_mark_waimai")
        }
        if dataModel.discount != nil {
            cell.markImageVIew3.image = UIImage(named: "icon_merchant_mark_paybill")
        }else if dataModel.isQueuing! != 0 {
            cell.markImageVIew3.image = UIImage(named: "icon_merchant_mark_queque")
        }
        
        //cell.setNeedsLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataModel = shopListModel.data[indexPath.row]
        let SPDVC = ShopDetailViewController(withModel: dataModel)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(SPDVC, animated: true)
        self.hidesBottomBarWhenPushed = false
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
