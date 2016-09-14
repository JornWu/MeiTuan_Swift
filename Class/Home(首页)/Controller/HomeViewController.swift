//
//  HomeViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit
import SDWebImage
import AFNetworking

class HomeViewController: BaseViewController, AddressViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    private var lBtn: UIButton!
    private var addressView: AddressView!
    private var areaArray: NSArray!
    
    var currentCity: String! {
        didSet {
            //addressView.currentCity = self.currentCity //联动改变
        }
    }
    
    ///menuView
    private var menuView: UIView!
    
    ///fushShopping
    private var rushShoppingModel: RushShoppingDataModel!//包含全部数据
    private var rushShoppingView: UIView!
    
    ///activity
    private var activityModel: AC_ActivityDataModel!//包含全部数据
    private var activityView: UIView!//响应事件
    
    ///recomment
    private var recommentModel: RE_RecommentDataModel!
    private var homeTableView: UITableView!
    private var headerView: UIView!//头视图
    private var isRefresh = false
    private var offset: Int64 = 0///请求数据的偏移量（从第几条获取）
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        currentCity = "上海"
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        addNavigationItems()
        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        currentCity = "上海"
        super.init(coder: aDecoder)
        
        addNavigationItems()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        creatAddressView()//确保地址栏放在最上面
        loadHeaderView()//头视图
    }
    
/****************************************************************************************************/
/**
 ** 添加导航栏按钮
 **
 */
    private func addNavigationItems() {
        ///left button item
        lBtn = UIButton(type: UIButtonType.Custom)
        lBtn.frame = CGRectMake(0, 0, 60, 35)
        lBtn.setTitle(currentCity, forState: UIControlState.Normal)
        lBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        lBtn.setImage(UIImage(named: "icon_homepage_downArrow"), forState: UIControlState.Normal)
        lBtn.setImage(UIImage(named: "icon_homepage_upArrow"), forState: UIControlState.Selected)
        lBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -36, 0, 0)
        lBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 36, 0, 0)
        lBtn.addTarget(self, action: #selector(leftItemAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem = UIBarButtonItem(customView: lBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        ///right button item
        let rBtn = UIButton(type: UIButtonType.Custom)
        rBtn.backgroundColor = UIColor.clearColor()
        rBtn.frame = CGRectMake(0, 0, 35, 35)
        rBtn.contentMode = UIViewContentMode.ScaleAspectFit
        rBtn.setImage(UIImage(named: "icon_homepage_shoppingCategory"), forState: UIControlState.Normal)
        rBtn.addTarget(self, action: #selector(shoppingCartButtonItemAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        let rightItem = UIBarButtonItem(customView: rBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        ///search test field
        let searchField = UITextField(frame: CGRectMake(0, 0, SCREENWIDTH * 0.5, 25))
        searchField.clipsToBounds = true
        searchField.layer.cornerRadius = searchField.extHeight() * 0.5
        searchField.borderStyle = .None
        searchField.backgroundColor = UIColor.whiteColor()
        
        let lView = UIImageView(frame: CGRectMake(5, 5, 15, 15))
        lView.image = UIImage(named: "icon_textfield_search")
        let lBgView = UIView(frame: CGRectMake(0, 0, 25, 25))
        lBgView.addSubview(lView)
        searchField.leftView = lBgView
        searchField.leftViewMode = .Always
        
        searchField.placeholder = "输入商家、品类、商圈"
        searchField.font = UIFont.systemFontOfSize(12)
        self.navigationItem.titleView = searchField
        
        searchField.delegate = self

    }
    
    ///UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
        hidesBottomBarWhenPushed = false
    }
    
/****************************************************************************************************/
/**
 ** 左边地址选择
 **
 */
    func leftItemAction(btn: UIButton) {
        btn.selected = !btn.selected
        addressView.hidden = !addressView.hidden
    }
    
    func creatAddressView() {
        addressView = AddressView(frame: self.view.bounds)
        addressView.delegate = self
        addressView.currentCity = self.currentCity
        addressView.hidden = true
        self.view.addSubview(addressView)
    }
     
    
    ///AddressViewDelegate
    func didClickedCellIntoCityList() {
        self.hidesBottomBarWhenPushed = true
        let cityListVC = CityListViewController()
        self.navigationController?.pushViewController(cityListVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    ///AddressViewDelegate
    func didClickedButtonWith(title: String) {
        lBtn.setTitle(title, forState: UIControlState.Normal)
        leftItemAction(lBtn)
        
        ///还要重新加载数据
    }
    
    ///AddressViewDelegate
    func listBgViewDidClicked() {
        leftItemAction(self.lBtn)
    }
    
/****************************************************************************************************/
/**
 ** 右边购物车视图
 **
 */
    func  shoppingCartButtonItemAction(btn: UIButton) {
        
        self.hidesBottomBarWhenPushed = true
        let shoppingCartVC = ShoppingCartViewController()
        self.navigationController?.pushViewController(shoppingCartVC, animated: true)
        self.hidesBottomBarWhenPushed = false
        
    }
/****************************************************************************************************/
/**
 ** menu视图
 **
 */
    func addMenuView(){
        menuView = MenuView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 190))
        headerView.addSubview(menuView)//add to headerView
    }
    
    
/****************************************************************************************************/
/**
 ** 名店抢购(封面)
 **
 */
    
    func loadRushShoppingData() {
        let URLString = UrlStrType.RushShopping.getUrlString()
        NetworkeProcessor.GET(URLString, parameters: nil, progress: nil, success: {
            [unowned self]//捕获列表，避免循环引用
            (task: NSURLSessionDataTask, responseObject: AnyObject?) in
            //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
            
            dispatch_async(dispatch_get_main_queue(), {///放到主线程中刷新UI
                self.rushShoppingModel(responseObject as! NSDictionary)
            })
            
            }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
            print("----获取数据失败----",responseObject)
        })
    }
    
    func rushShoppingModel(dictionary: NSDictionary) {
        
        rushShoppingModel = RushShoppingDataModel(fromDictionary: dictionary)
        creatRushShoppingView()
        
    }
    
    func creatRushShoppingView() {
        rushShoppingView = UIView(frame: CGRectMake(0, 190 + 10, SCREENWIDTH, 120))//20 是空隙
        rushShoppingView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(rushShoppingView)//add to headerView
        
        let titleImageView = UIImageView(frame: CGRectMake(10, 0, 70, 30))
        rushShoppingView.addSubview(titleImageView)
        titleImageView.image = UIImage(named: "todaySpecialHeaderTitleImage@3x.png")
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        let itemContainView = UIView(frame: CGRectMake(0, titleImageView.extHeight() + titleImageView.extY(), SCREENWIDTH, rushShoppingView.extHeight() - titleImageView.extHeight()))
        itemContainView.backgroundColor = UIColor.whiteColor()
        rushShoppingView.addSubview(itemContainView)
        
        let lineView = UIView(frame: CGRectMake(0, 10, SCREENWIDTH, itemContainView.extHeight() - 20))//衬托背景线条（多种方式，在这取巧实现）
        lineView.backgroundColor = UIColor.grayColor()
       // lineView.center = CGPointMake(itemContainView.center.x, itemContainView.center.y)
        itemContainView.addSubview(lineView)
        
        
        let dealAr = rushShoppingModel.data.deals
        
        for index in 0..<dealAr.count {
            let itemBgView = UIView()
            itemBgView.backgroundColor = UIColor.whiteColor()

            let itemBgViewWidth = CGFloat(SCREENWIDTH - 2) / CGFloat(dealAr.count)
            
            if index == 0 {
                itemBgView.frame = CGRectMake(0, 0, itemBgViewWidth, 90)
            }else if index == 1 {
                itemBgView.frame = CGRectMake(itemBgViewWidth + 1, 0, itemBgViewWidth, 90)
            }else if index == 2 {
                itemBgView.frame = CGRectMake((itemBgViewWidth + 1) * 2, 0, itemBgViewWidth, 90)
            }
            
            let itemVC = RushShoppingItem(nibName: "RushShoppingItem", bundle: nil) as RushShoppingItem
            itemVC.view.frame = CGRectMake((itemBgView.extWidth() - itemVC.view.extWidth()) * 0.5, 18, 84, 64)
            itemBgView.addSubview(itemVC.view)
            
            
            let deal = dealAr[index]
            itemVC.imageView.sd_setImageWithURL(NSURL(string: deal.imgurl), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
            
            let valueStr = NSMutableAttributedString(string: "\(deal.value)元")
            valueStr.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.StyleSingle.hashValue, range: NSMakeRange(0, valueStr.length))
            valueStr.addAttribute(NSStrikethroughColorAttributeName, value: colorWithRGBA(33, g: 192, b: 174, a: 1), range: NSMakeRange(0, valueStr.length))
            
            itemVC.oldPriceLB.attributedText = valueStr
            let yuan = "元"
            itemVC.newPriceLB.text = String(deal.price) + yuan
            
            itemContainView.addSubview(itemBgView)
        }
        
        let faceBtn = UIButton(frame: rushShoppingView.bounds)
        faceBtn.addTarget(self, action: #selector(HomeViewController.intoRushShoppingDetailView), forControlEvents: UIControlEvents.TouchUpInside)
        rushShoppingView.addSubview(faceBtn)
    }
    
    func intoRushShoppingDetailView() {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(H5ViewController(urlString: UrlStrType.RushBuyWebData.getUrlString()), animated: true)
        self.hidesBottomBarWhenPushed = false
    }
     
/****************************************************************************************************/
/**
 ** 活动(封面，六个模块)
 **
 */
    
    
    func loadActivityData() {
        
        ///活动数据
        let dicountURLString = UrlStrType.Activity.getUrlString()
        NetworkeProcessor.GET(dicountURLString, parameters: nil, progress: nil, success: {
            [unowned self]//捕获列表，避免循环引用
            (task, responseObject) in
            //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
            
            dispatch_async(dispatch_get_main_queue(), {///放到主线程中刷新UI
                self.activityModelWith(responseObject as! NSDictionary)
            })
            
            }, failure: {(task, error)in
                print("----获取数据失败----",error.localizedDescription)
        })
    }
    
    func activityModelWith(dictionary: NSDictionary) {
        
        activityModel = AC_ActivityDataModel(fromDictionary: dictionary)
        creatActivityView()

    }
    
    func creatActivityView() {
        activityView = UIView(frame: CGRectMake(0, 320 + 10, SCREENWIDTH, 212))
        activityView.backgroundColor = UIColor.grayColor()
        headerView.addSubview(activityView)//add to headerView
        
        let dataAr = activityModel.data
        
        for index in 0..<dataAr.count {
            
            let h = CGFloat(70) //item的高，由xib固定
            let w = (SCREENWIDTH - 1) / 2 //item的宽
            let r = index / 2 //所在行
            let c = index % 2 //所在列
            
            let itemBgView = UIView(frame: CGRectMake((w + CGFloat(1)) * CGFloat(c), (h + CGFloat(1)) * CGFloat(r), w, h)) //响应事件
            
            let itemVC = ActivityItem(nibName: "ActivityItem", bundle: nil) as ActivityItem
            itemVC.view.frame = CGRectMake(0, 0, itemBgView.extWidth(), itemBgView.extHeight())
            itemBgView.addSubview(itemVC.view)
            
            let data = dataAr[index] 
            itemVC.titleLB.text = data.maintitle
            itemVC.titleLB.textColor = UIColor.hexStringToColor(data.typefaceColor)
            itemVC.detailLB.text = data.deputytitle
            itemVC.detailLB.textColor = UIColor.hexStringToColor(data.deputyTypefaceColor)
            itemVC.imageView.sd_setImageWithURL(NSURL(string: data.imageurl), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
            
            itemBgView.backgroundColor = UIColor.whiteColor()
            activityView.addSubview(itemBgView)
            
            let faceBtn = UIButton(frame: CGRectMake(0, 0, w, h)) //覆盖在item上的透明的btn，用于响应事件（Multiple Way）
            faceBtn.tag = 2000 + index
            faceBtn.addTarget(self, action: #selector(HomeViewController.acItemButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            itemBgView.addSubview(faceBtn)
            
        }
    }
    
    func acItemButtonAction(btn: UIButton) {
//        print(btn.tag)
        ///进入详情页面
        let dataAr = activityModel.data
        let urlString = dataAr[(btn.tag - 2000)].share.url
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(H5ViewController(urlString: urlString), animated: true)
        self.hidesBottomBarWhenPushed = false
    }
     
     
     
/****************************************************************************************************/
/**
 ** 猜你喜欢
 **
 */
    
    func loadHeaderView() {
        self.view.bringSubviewToFront(self.activityIndicatorView)
        self.activityIndicatorView.hidden = false ///让activityView显示///首页可能被启动页面遮住
        
        headerView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 212 + 190 + 120 + 30 + 50 + 10))
        headerView.backgroundColor =  colorWithRGBA(210, g: 210, b: 210, a: 1)
        
        let blankView = UIView(frame: CGRectMake(0, 212 + 190 + 120 + 30, SCREENWIDTH, 50))
        blankView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(blankView)//空白修饰视图（添加额外内容和通知）
        
        let email = UILabel(frame: CGRectMake(10, 0, SCREENWIDTH - 20, 15))
        email.text = "有问题请投递：jorn_wza@sina.com QQ:1249233155"
        email.font = UIFont.systemFontOfSize(13)
        email.textColor = UIColor.redColor()
        blankView.addSubview(email)
        let blog = UILabel(frame: CGRectMake(10, 15, SCREENWIDTH - 20, 15))
        blog.text = "微博：JornWu丶WwwwW 博客：http://blog.sina.com.cn/u/5077687473"
        blog.numberOfLines = 0
        blog.font = UIFont.systemFontOfSize(11)
        blog.textColor = THEMECOLOR
        blankView.addSubview(blog)
        let update = UILabel(frame: CGRectMake(10, 30, SCREENWIDTH - 20, 15))
        update.text = "功能持续更新，相互学习，共同进步。"
        update.numberOfLines = 0
        update.font = UIFont.systemFontOfSize(11)
        update.textColor = THEMECOLOR
        blankView.addSubview(update)
        
        self.addMenuView()//不用网络
        
        let OP1 = NSBlockOperation {
            [unowned self]
            () -> Void in
            self.loadRushShoppingData()
        }
        
        let OP2 = NSBlockOperation {
            [unowned self]
            () -> Void in
            self.loadActivityData()
        }
        
        let OP3 = NSBlockOperation {
            [unowned self]
            () -> Void in
            self.loadRecommentData()
        }
        
        OP3.addDependency(OP2)
        OP2.addDependency(OP1)//确保前面的视图都创建完成再创建表视图
        
        let QE = NSOperationQueue()
        QE.addOperation(OP1)
        QE.addOperation(OP2)
        QE.addOperation(OP3)
        
        QE.waitUntilAllOperationsAreFinished()
        self.activityIndicatorView.hidden = true ///让activityView隐藏
    }
    
    func loadRecommentData() {
        ///推荐
        let recommentURLString = UrlStrType.Recomment.getUrlString()
        NetworkeProcessor.GET(recommentURLString, parameters: nil, progress: nil, success: {
            [unowned self]//捕获列表，避免循环引用
            (task, responseObject) -> Void in
            //print("----获取数据成功----",responseObject)
            
            dispatch_async(dispatch_get_main_queue(), {///放到主线程中刷新UI
                self.recommentModelWith(responseObject as! NSDictionary)
            })
            
        }) { (task, error) -> Void in
                print("----获取数据失败----",error.localizedDescription)
            
        }
        
    }
    
    func recommentModelWith(dictionary: NSDictionary) {
        
        recommentModel = RE_RecommentDataModel(fromDictionary: dictionary)
        if !isRefresh {
            creatHomeTableView()
        }else {
            homeTableView.reloadData()
            isRefresh = false///还原
        }

    }
    
    func creatHomeTableView(){
        
        homeTableView = UITableView(frame: CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49), style: UITableViewStyle.Plain)
        homeTableView.backgroundColor = colorWithRGBA(210, g: 210, b: 210, a: 1)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        self.view.insertSubview(homeTableView, atIndex: 0)
        
        ///添加头视图
        homeTableView.tableHeaderView = headerView
        
        ///添加上拉加载和下拉刷新视图
        addRefreshView()

        homeTableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")//从xib加载
        
    }
    
    func addRefreshView() {///添加刷新视图
        
        ///refresh视图
        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        
        ///设置普通状态的动画图片
        var idleImages = [UIImage]() ///创建数字对象
        for i in 1 ... 60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            idleImages.append(image!)
        }
        
        header.setImages(idleImages, forState: .Idle)
        
        //设置即将刷新状态的动画图片
        var refreshingImages = [UIImage]()
        for i in 1 ... 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshingImages.append(image!)
        }
        
//        // 隐藏时间
//        header.lastUpdatedTimeLabel.hidden = true
//        // 隐藏状态
//        header.stateLabel.hidden = true
        
        header.setImages(idleImages, forState: .Idle)///正常
        header.setImages(refreshingImages, forState: .Pulling)///下拉过程
        header.setImages(refreshingImages, forState: .Refreshing)///刷新过程
        
        header.setTitle("下拉刷新", forState: .Idle)
        header.setTitle("释放开始刷新", forState: .Pulling)
        header.setTitle("正在刷新数据中...", forState: .Refreshing)
        
        ///设置文字样式，footer类似
//        header.stateLabel.font
//        header.stateLabel.textColor
//        header.lastUpdatedTimeLabel.font
//        header.lastUpdatedTimeLabel.textColor
        
        homeTableView.mj_header = header
        
        let footer = MJRefreshAutoGifFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        footer.setImages(refreshingImages, forState: .Refreshing)///加载过程
        homeTableView.mj_footer = footer
    }
    
    ///下拉刷新
    func loadNewData() {

        ///直接调用上面的代码重新获取新数据
        isRefresh = true
        
        let OP1 = NSBlockOperation {
            [unowned self]
            () -> Void in
            self.loadRushShoppingData()///重装数据
        }
        
        let OP2 = NSBlockOperation {
            [unowned self]
            () -> Void in
            self.loadActivityData()///重装数据
        }
        
        let OP3 = NSBlockOperation {
            [unowned self]
            () -> Void in
            self.loadRecommentData()///重装数据
        }
        
        OP3.addDependency(OP2)
        OP2.addDependency(OP1)//确保前面的视图都创建完成再创建表视图
        
        let QE = NSOperationQueue()
        QE.addOperation(OP1)
        QE.addOperation(OP2)
        QE.addOperation(OP3)
        
        QE.waitUntilAllOperationsAreFinished()///全部加载完成
        self.homeTableView.mj_header.endRefreshing()///停止刷新
    }
    
    ///上拉加载
    func loadMoreData() {
        offset += 10///每次上来添加10条
        
        ///新建一个缓冲数组接受新数据，然后再添加到原数组后面，然后再reload表格（因接口原因，在此没法实现了）
        
        ///推荐
        let recommentURLString = UrlStrType.urlStringWithRecommentStr(0)///offset
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) { () -> Void in
            
            NetworkeProcessor.GET(recommentURLString, parameters: nil, progress: {
                
                [unowned self]
                (progress: NSProgress) in
                
                if progress.fractionCompleted == 1 {//下载完成
                    self.homeTableView.mj_footer.endRefreshing()///停止刷新
                }
                
                }, success: {
                    (task: NSURLSessionDataTask, responseObject: AnyObject?) in
                    //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
                    
                    ///返回主线程刷新UI
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.isRefresh = true
                        self.recommentModelWith(responseObject as! NSDictionary)/// test
                        self.homeTableView.reloadData()///刷新表格数据
                        
                    })
                    
                }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                    print("----获取数据失败----",responseObject)
            })
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommentModel.data.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            cell.textLabel!.text = recommentModel.tab.tabTitle + "," + recommentModel.tab.normalTitle
            cell.textLabel!.textColor = THEMECOLOR
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }else {
            
            let cell = HomeTableViewCell.creatCellWith(tableView, indexPath: indexPath, reuseIdentifier: "HomeCell") as HomeTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let dataItem = recommentModel.data[indexPath.row - 1]
            cell.ImageView.sd_setImageWithURL(NSURL(string: dataItem.imgurl), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
            cell.titleLB.text = dataItem.mname
            cell.detailLB.text = "[" + dataItem.range + "]" + dataItem.mtitle
            cell.priceLB.text = "\(dataItem.price)" + "元"
            cell.priceLB.textColor = THEMECOLOR
            
            cell.valueLB.text = "门面价：" + "\(dataItem.value)" + "元"
            cell.valueLB.textColor = UIColor.grayColor()
            cell.salesLB.text = "已卖" + "\(dataItem.solds)" + "份"
            cell.salesLB.textColor = THEMECOLOR
            return cell 
        }
 
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 30
        }else {
            return 126
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dataItem = recommentModel.data[indexPath.row - 1]
        let HTVC = HotelViewController(dataModel: dataItem)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(HTVC, animated: true)
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
