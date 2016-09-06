//
//  ShopDetailViewController.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/8/29.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是商家列表的详情页,此页面为简化页面
**
*/
/****************************************************************************************************/


import UIKit

class ShopDetailViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataModel: SP_Data!
    
    private var navigationView: UIView!
    private var navigationColorView: UIView!
    private var backBtn: UIButton!
    private var collectBtn: UIButton!
    private var shareBtn: UIButton!
    private var massageBtn: UIButton!
    private var titleLB: UILabel!
    
    private var headerView: UIView!
    
    private var shopDetailTableView: UITableView!
    
    private var aroundGroupPurchaseModel: AGP_AroundGroupPurchaseModel!
    
    private var shopAddress: String!
    
    convenience init(withModel model: SP_Data) {
        self.init()
        
        dataModel = model
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
        creatHeaderImageView()
        loadAroundGroupPurchaseData()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.hidden = true
        
        navigationColorView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 64))
        navigationColorView.backgroundColor = UIColor.whiteColor()
        navigationColorView.alpha = 0
        self.view.addSubview(navigationColorView)
        
        navigationView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 64))
        navigationView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(navigationView)
        
        backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.frame = CGRectMake(10, 30, 25, 25)
        backBtn.tag = 400
        backBtn.setImage(UIImage(named: "btn_backItem"), forState: UIControlState.Normal)
        backBtn.setImage(UIImage(named: "btn_backItem_highlighted"), forState: UIControlState.Highlighted)
        backBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(backBtn)
        
        massageBtn = UIButton(type: UIButtonType.Custom)
        massageBtn.frame = CGRectMake(SCREENWIDTH - 10 - 25, 30, 25, 25)
        massageBtn.tag = 401
        massageBtn.setImage(UIImage(named: "icon_merchan_error_normal"), forState: UIControlState.Normal)
        massageBtn.setImage(UIImage(named: "icon_merchan_error_highlighted"), forState: UIControlState.Highlighted)
        massageBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(massageBtn)
        
        shareBtn = UIButton(type: UIButtonType.Custom)
        shareBtn.frame = CGRectMake(CGRectGetMinX(massageBtn.frame) - 10 - 25, 30, 25, 25)
        shareBtn.tag = 402
        shareBtn.setImage(UIImage(named: "icon_merchant_share_normal"), forState: UIControlState.Normal)
        shareBtn.setImage(UIImage(named: "icon_merchant_share_highlighted"), forState: UIControlState.Highlighted)
        shareBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(shareBtn)
        
        collectBtn = UIButton(type: UIButtonType.Custom)
        collectBtn.frame = CGRectMake(CGRectGetMinX(shareBtn.frame) - 10 - 25, 30, 25, 25)
        collectBtn.tag = 403
        collectBtn.setImage(UIImage(named: "iocn_merchant_collect_normal"), forState: UIControlState.Normal)
        collectBtn.setImage(UIImage(named: "iocn_merchant_collect_highlighted"), forState: UIControlState.Selected)
        collectBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(collectBtn)
        
        titleLB = UILabel(frame: CGRectMake(CGRectGetMaxX(backBtn.frame) + 10, 30, CGRectGetMinX(collectBtn.frame) - 10 - (10 + 10 + 25), 25))
        titleLB.text = dataModel.name
        titleLB.textAlignment = NSTextAlignment.Right
        titleLB.hidden = true
        navigationView.addSubview(titleLB)
        
        self.view.backgroundColor = BACKGROUNDCOLOR
    }
    
    func navigationBtnAction(btn: UIButton) {
        if btn.tag == 400 {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }else if btn.tag == 401 {
            //doing
        }else if btn.tag == 402 {
            //doing
        }else {
            //doing
            btn.selected = !btn.selected
        }
    }
    
    func creatHeaderImageView() {
        headerView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 150))
        let imageView = UIImageView(frame: headerView.bounds)
        headerView.addSubview(imageView)
        self.view.insertSubview(headerView, atIndex: 0)
        imageView.sd_setImageWithURL(NSURL(string: dataModel.frontImg), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
    }
    
    
    ///可以直接使用封装的方法
    func loadAroundGroupPurchaseData() {
        let URLString = UrlStrType.urlStringWithMerchantAroundGroupPurchaseData(dataModel.poiid)
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
                        self.aroundGroupPurchaseModel(withDictionary: responseObject as! NSDictionary)
                    })
                    
                }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                    print("----获取数据失败----",responseObject)
            })
        }
    }
    
    ///附近团购model
    func aroundGroupPurchaseModel(withDictionary dictionary: NSDictionary) {
        aroundGroupPurchaseModel = AGP_AroundGroupPurchaseModel(fromDictionary: dictionary)
        creatShopDetailTableView()
    }
    
    func creatShopDetailTableView() {
        shopDetailTableView = UITableView(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT), style: UITableViewStyle.Grouped)
        shopDetailTableView.delegate = self
        shopDetailTableView.dataSource = self
        
        shopDetailTableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 150))//占位
        
        ///将就使用HomeTableViewCell（风格类似，学习者可以参考HomeTableViewCell实现）
        shopDetailTableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "AGP_Cell")//从xib加载
        
        self.view.insertSubview(shopDetailTableView, atIndex: 0)

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3 //简化
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1 {
            return 1
        }else {
            return aroundGroupPurchaseModel.data.deals.count + 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                cell.textLabel!.text = dataModel.name
                cell.textLabel?.font = UIFont.systemFontOfSize(19)
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }else {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                
                let containView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 60))
                let lineView = UIView(frame: CGRectMake(0, 10, SCREENWIDTH, 40))
                lineView.backgroundColor = UIColor.grayColor()
                containView.addSubview(lineView)

                cell.contentView.addSubview(containView)
                
                let leftView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH - 70 - 1, 60))
                leftView.backgroundColor  = UIColor.whiteColor()
                let locationBtn = UIButton(frame: CGRectMake(10, 0, leftView.extWidth() - 20, 60))
                locationBtn.setImage(UIImage(named: "icon_merchant_location"), forState: UIControlState.Normal)
                locationBtn.setTitle(dataModel.addr, forState: UIControlState.Normal)
                locationBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                locationBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
                locationBtn.titleLabel?.numberOfLines = 0
                locationBtn.contentMode = UIViewContentMode.Left
                leftView.addSubview(locationBtn)
                
                let rightView = UIView(frame: CGRectMake(leftView.extWidth() + 1, 0, 70, 60))
                rightView.backgroundColor  = UIColor.whiteColor()
                let callBtn = UIButton(frame: rightView.bounds)
                callBtn.setImage(UIImage(named: "icon_deal_phone"), forState: UIControlState.Normal)
                callBtn.tintColor = UIColor.grayColor()
                rightView.addSubview(callBtn)
                
                containView.addSubview(rightView)
                containView.addSubview(leftView)
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }
        }else if indexPath.section == 1 {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            
            //评分
            let starView = StarView(withRate: CGFloat(dataModel.avgScore), total: 5, starWH: 30, space: 3, starImageFull: UIImage(named: "icon_merchant_star_full")!, starImageEmpty: UIImage(named: "icon_merchant_star_empty")!)
            starView.extSetY((cell.contentView.extHeight() - starView.extHeight()) / 2 + 3)
            cell.contentView.addSubview(starView)
            
            let ratingLB = UILabel(frame: CGRectMake(CGRectGetMaxX(starView.frame) + 10, starView.extY() + 3, 100, 30))
            ratingLB.text = "\(dataModel.avgScore)" + "分"
            cell.contentView.addSubview(ratingLB)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else {
            if indexPath.row == 0 {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                cell.textLabel!.text = "附近团购"
                cell.textLabel?.textColor = UIColor.grayColor()
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }else if indexPath.row == 1 {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                
                let dataModel = aroundGroupPurchaseModel.data
                
                for index in 0 ..< dataModel.catetab.count {
                    
                    let c = index % 4
                    let btnW = (SCREENWIDTH - 10 * 5) / CGFloat(dataModel.catetab.count)
                    
                    let tabBtn = UIButton(frame: CGRectMake(10 + (10 + btnW) * CGFloat(c), 10, btnW, 30))
                    tabBtn.tag = index
                    
                    let edge = UIEdgeInsetsMake(10, 5, 10, 5)
                    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
                    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
                    var bgImageH = UIImage(named: "bg_merchant_checkRoute_highlight")
                    bgImageH = bgImageH?.resizableImageWithCapInsets(edge, resizingMode: UIImageResizingMode.Stretch)
                    var bgImageN = UIImage(named: "bg_merchant_checkRoute_normal")
                    bgImageN = bgImageN?.resizableImageWithCapInsets(edge, resizingMode: UIImageResizingMode.Stretch)
                    
                    tabBtn.setBackgroundImage(bgImageH, forState: UIControlState.Highlighted)
                    tabBtn.setBackgroundImage(bgImageN, forState: UIControlState.Normal)
                    
                    tabBtn.setTitle(dataModel.catetab[index].name, forState: UIControlState.Normal)
                    tabBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                    tabBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
                    tabBtn.addTarget(self, action: #selector(ShopDetailViewController.tabBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                    
                    cell.contentView.addSubview(tabBtn)
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            }else {
                let cell = HomeTableViewCell.creatCellWith(tableView, indexPath: indexPath, reuseIdentifier: "AGP_Cell")
                
                let dealModel = aroundGroupPurchaseModel.data.deals[indexPath.row - 2]
                cell.ImageView.sd_setImageWithURL(NSURL(string: dealModel.imgurl), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
                cell.titleLB.text = dealModel.mname
                cell.detailLB.text = "[" + dealModel.range + "]" + dealModel.mtitle
                cell.priceLB.text = "\(dealModel.price)" + "元"
                cell.priceLB.textColor = THEMECOLOR
                
                cell.valueLB.text = "门面价：" + "\(dealModel.value)" + "元"
                cell.valueLB.textColor = UIColor.grayColor()
                cell.salesLB.text = "\(dealModel.rating)" + "分" + "(" + "\(dealModel.ratecount)" + "人)"
                cell.salesLB.textColor = UIColor.grayColor()
                
                return cell
            }
        }
    }
    
    ///四个标签的响应
    func tabBtnAction(btn: UIButton) {
        ///
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 60
        }else if indexPath.section == 1 {
            return 50
        }else {
            if indexPath.row == 0 {
                return 40
            }else if indexPath.row == 1 {
                return 50
            }else {
                return 126
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ///进入团购详情页面（暂未实现）
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001 // 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001 // 0
        }else {
            return 10
        }
    }
    
    ///图片的拉伸动画效果和导航bar的颜色变化效果
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let off = shopDetailTableView.contentOffset.y
        if off < 0 {//图片的拉伸动画效果
            let scale = (-off + 150) / 150;
            headerView.transform = CGAffineTransformMakeScale(scale, scale);   //  拉伸放大
            
            let newH = scale * 150;
            let newW = scale * SCREENWIDTH;
            let frame = CGRectMake(-(scale - 1) * SCREENWIDTH / 2, 0, newW, newH);
            headerView.frame = frame;
            
        }else {
            headerView.transform = CGAffineTransformMakeTranslation(0, -off);      //上推上移
        }
        
        if off > 0 {//导航条的颜色变化效果 //向上推
            let al = off / 150.0 //透明度
            if al < 1 {
                
                navigationColorView.alpha = al
                
                if al > 0.5 {
                    titleLB.hidden = false
                }else {
                    titleLB.hidden = true
                }
                
            }else {
                navigationColorView.alpha = 1
            }
        }
        
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
