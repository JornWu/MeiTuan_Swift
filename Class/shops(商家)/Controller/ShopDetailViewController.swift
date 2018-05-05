//
//  ShopDetailViewController.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/8/29.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/*
 *******************************************************************************
 *   这是商家列表的详情页,此页面为简化页面
 *******************************************************************************
 */


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
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationColorView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 64))
        navigationColorView.backgroundColor = UIColor.white
        navigationColorView.alpha = 0
        self.view.addSubview(navigationColorView)
        
        navigationView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 64))
        navigationView.backgroundColor = UIColor.clear
        self.view.addSubview(navigationView)
        
        backBtn = UIButton(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 10, y: 30, width: 25, height: 25)
        backBtn.tag = 400
        backBtn.setImage(UIImage(named: "btn_backItem"), for: UIControlState())
        backBtn.setImage(UIImage(named: "btn_backItem_highlighted"), for: UIControlState.highlighted)
        backBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(backBtn)
        
        massageBtn = UIButton(type: UIButtonType.custom)
        massageBtn.frame = CGRect(x: SCREENWIDTH - 10 - 25, y: 30, width: 25, height: 25)
        massageBtn.tag = 401
        massageBtn.setImage(UIImage(named: "icon_merchan_error_normal"), for: UIControlState())
        massageBtn.setImage(UIImage(named: "icon_merchan_error_highlighted"), for: UIControlState.highlighted)
        massageBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(massageBtn)
        
        shareBtn = UIButton(type: UIButtonType.custom)
        shareBtn.frame = CGRect(x: massageBtn.frame.minX - 10 - 25, y: 30, width: 25, height: 25)
        shareBtn.tag = 402
        shareBtn.setImage(UIImage(named: "icon_merchant_share_normal"), for: UIControlState())
        shareBtn.setImage(UIImage(named: "icon_merchant_share_highlighted"), for: UIControlState.highlighted)
        shareBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(shareBtn)
        
        collectBtn = UIButton(type: UIButtonType.custom)
        collectBtn.frame = CGRect(x: shareBtn.frame.minX - 10 - 25, y: 30, width: 25, height: 25)
        collectBtn.tag = 403
        collectBtn.setImage(UIImage(named: "iocn_merchant_collect_normal"), for: UIControlState())
        collectBtn.setImage(UIImage(named: "iocn_merchant_collect_highlighted"), for: UIControlState.selected)
        collectBtn.addTarget(self, action: #selector(ShopDetailViewController.navigationBtnAction(_:)), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(collectBtn)
        
        titleLB = UILabel(frame: CGRect(x: backBtn.frame.maxX + 10, y: 30, width: collectBtn.frame.minX - 10 - (10 + 10 + 25), height: 25))
        titleLB.text = dataModel.name
        titleLB.textAlignment = NSTextAlignment.right
        titleLB.isHidden = true
        navigationView.addSubview(titleLB)
        
        self.view.backgroundColor = BACKGROUNDCOLOR
    }
    
    func navigationBtnAction(_ btn: UIButton) {
        if btn.tag == 400 {
            self.navigationController?.popToRootViewController(animated: true)
        }else if btn.tag == 401 {
            //doing
        }else if btn.tag == 402 {
            //doing
        }else {
            //doing
            btn.isSelected = !btn.isSelected
        }
    }
    
    func creatHeaderImageView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 150))
        let imageView = UIImageView(frame: headerView.bounds)
        headerView.addSubview(imageView)
        self.view.insertSubview(headerView, at: 0)
        imageView.sd_setImage(with: URL(string: dataModel.frontImg), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
    }
    
    
    func loadAroundGroupPurchaseData() {
        
        self.view.bringSubview(toFront: self.activityIndicatorView)
        self.activityIndicatorView.isHidden = false ///让activityView显示
        
        let URLString = UrlStrType.urlStringWithMerchantAroundGroupPurchaseData(dataModel.poiid)        
        ///封装的方法
        NetworkeProcessor.loadNetworkeDate(withTarget: self, URLString: URLString) {
            [unowned self]
            (dictionary) in
            self.aroundGroupPurchaseModel(withDictionary: dictionary)
            self.activityIndicatorView.isHidden = true ///让activityView隐藏
        }
    }
    
    ///附近团购model
    func aroundGroupPurchaseModel(withDictionary dictionary: NSDictionary) {
        aroundGroupPurchaseModel = AGP_AroundGroupPurchaseModel(fromDictionary: dictionary)
        creatShopDetailTableView()
    }
    
    func creatShopDetailTableView() {
        shopDetailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), style: UITableViewStyle.grouped)
        shopDetailTableView.delegate = self
        shopDetailTableView.dataSource = self
        
        shopDetailTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 150))//占位
        
        ///将就使用HomeTableViewCell（风格类似，学习者可以参考HomeTableViewCell实现）
        shopDetailTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "AGP_Cell")//从xib加载
        
        self.view.insertSubview(shopDetailTableView, at: 0)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 //简化
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1 {
            return 1
        }else {
            return aroundGroupPurchaseModel.data.deals.count + 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
                cell.textLabel!.text = dataModel.name
                cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }else {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
                
                let containView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 60))
                let lineView = UIView(frame: CGRect(x: 0, y: 10, width: SCREENWIDTH, height: 40))
                lineView.backgroundColor = UIColor.gray
                containView.addSubview(lineView)

                cell.contentView.addSubview(containView)
                
                let leftView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH - 70 - 1, height: 60))
                leftView.backgroundColor  = UIColor.white
                let locationBtn = UIButton(frame: CGRect(x: 10, y: 0, width: leftView.extWidth() - 20, height: 60))
                locationBtn.setImage(UIImage(named: "icon_merchant_location"), for: UIControlState())
                locationBtn.setTitle(dataModel.addr, for: UIControlState())
                locationBtn.setTitleColor(UIColor.gray, for: UIControlState())
                locationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                locationBtn.titleLabel?.numberOfLines = 0
                locationBtn.contentMode = UIViewContentMode.left
                leftView.addSubview(locationBtn)
                
                let rightView = UIView(frame: CGRect(x: leftView.extWidth() + 1, y: 0, width: 70, height: 60))
                rightView.backgroundColor  = UIColor.white
                let callBtn = UIButton(frame: rightView.bounds)
                callBtn.setImage(UIImage(named: "icon_deal_phone"), for: UIControlState())
                callBtn.tintColor = UIColor.gray
                callBtn.addTarget(self, action: #selector(callBtnAction), for: .touchUpInside)
                rightView.addSubview(callBtn)
                
                containView.addSubview(rightView)
                containView.addSubview(leftView)
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }
        }else if indexPath.section == 1 {
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
            
            //评分
            let starView = StarView(withRate: CGFloat(dataModel.avgScore), total: 5, starWH: 30, space: 3, starImageFull: UIImage(named: "icon_merchant_star_full")!, starImageEmpty: UIImage(named: "icon_merchant_star_empty")!)
            starView.extSetY((cell.contentView.extHeight() - starView.extHeight()) / 2 + 3)
            cell.contentView.addSubview(starView)
            
            let ratingLB = UILabel(frame: CGRect(x: starView.frame.maxX + 10, y: starView.extY() + 3, width: 100, height: 30))
            ratingLB.text = "\(dataModel.avgScore!)" + "分"
            cell.contentView.addSubview(ratingLB)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else {
            if indexPath.row == 0 {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
                cell.textLabel!.text = "附近团购"
                cell.textLabel?.textColor = UIColor.gray
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }else if indexPath.row == 1 {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
                
                let dataModel = aroundGroupPurchaseModel.data
                
                for index in 0 ..< dataModel!.catetab.count {
                    
                    let c = index % 4
                    let btnW = (SCREENWIDTH - 10 * 5) / CGFloat((dataModel?.catetab.count)!)
                    
                    let tabBtn = UIButton(frame: CGRect(x: 10 + (10 + btnW) * CGFloat(c), y: 10, width: btnW, height: 30))
                    tabBtn.tag = index
                    
                    let edge = UIEdgeInsetsMake(10, 5, 10, 5)
                    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
                    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
                    var bgImageH = UIImage(named: "bg_merchant_checkRoute_highlight")
                    bgImageH = bgImageH?.resizableImage(withCapInsets: edge, resizingMode: UIImageResizingMode.stretch)
                    var bgImageN = UIImage(named: "bg_merchant_checkRoute_normal")
                    bgImageN = bgImageN?.resizableImage(withCapInsets: edge, resizingMode: UIImageResizingMode.stretch)
                    
                    tabBtn.setBackgroundImage(bgImageH, for: UIControlState.highlighted)
                    tabBtn.setBackgroundImage(bgImageN, for: UIControlState())
                    
                    tabBtn.setTitle(dataModel?.catetab[index].name, for: UIControlState())
                    tabBtn.setTitleColor(UIColor.gray, for: UIControlState())
                    tabBtn.setTitleColor(UIColor.white, for: UIControlState.highlighted)
                    tabBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                    tabBtn.addTarget(self, action: #selector(ShopDetailViewController.tabBtnAction(_:)), for: UIControlEvents.touchUpInside)
                    
                    cell.contentView.addSubview(tabBtn)
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }else {
                let cell = HomeTableViewCell.creatCellWith(tableView, indexPath: indexPath, reuseIdentifier: "AGP_Cell")
                
                let dealModel = aroundGroupPurchaseModel.data.deals[indexPath.row - 2]
                cell.ImageView.sd_setImage(with: URL(string: dealModel.imgurl), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
                cell.titleLB.text = dealModel.mname
                cell.detailLB.text = "[\(dealModel.range ?? "")]\(dealModel.mtitle ?? "")"
                
                if let price = dealModel.price {
                    cell.priceLB.text = "\(price)元"
                } else {
                    cell.priceLB.text = "无"
                }
                cell.priceLB.textColor = THEMECOLOR
                
                if let val = dealModel.value {
                    cell.valueLB.text = "门面价：\(val)元"
                } else {
                    cell.valueLB.text = "门面价：无"
                }
                cell.valueLB.textColor = UIColor.gray
                
                if let rate = dealModel.rating {
                    cell.salesLB.text = "\(rate)分(\(dealModel.ratecount!)人)"
                } else {
                    cell.salesLB.text = "无"
                }
                cell.salesLB.textColor = UIColor.gray
                
                return cell
            }
        }
    }
    
    ///拨打电话
    func callBtnAction() {
        let actionSheetVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let numbers = dataModel.phone.components(separatedBy: "/")
        
        for index in numbers {///可能不只有一个电话
            let action = UIAlertAction(title: index, style: .default) {
                [unowned self]
                (action) in
                self.call(withNumber: action.title!)
            }
            actionSheetVC.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            print("取消了拨打电话")
        }
        actionSheetVC.addAction(cancelAction)
        
        self.present(actionSheetVC, animated: true) { 
            print("是否拨打电话？")
        }
    }
    
    func call(withNumber number: String) {
        let numberURL = URL(string: "telprompt://" + number)
        ///还可以用tel: ...的形势，但是打完电话不会回到改app，而且点击之后立即拨打，没有对话框，建议使用上方式
        
        UIApplication.shared.openURL(numberURL!) ///发短息，打电话，发邮件等，都只要一个URL就可以
    }
    
    ///四个标签的响应
    func tabBtnAction(_ btn: UIButton) {
        ///
        print("点击了:",btn.titleLabel?.text as Any)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///进入团购详情页面（暂未实现）
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001 // 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001 // 0
        }else {
            return 10
        }
    }
    
    ///图片的拉伸动画效果和导航bar的颜色变化效果
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let off = shopDetailTableView.contentOffset.y
        if off < 0 {//图片的拉伸动画效果
            let scale = (-off + 150) / 150;
            headerView.transform = CGAffineTransform(scaleX: scale, y: scale);   //  拉伸放大
            
            let newH = scale * 150;
            let newW = scale * SCREENWIDTH;
            let frame = CGRect(x: -(scale - 1) * SCREENWIDTH / 2, y: 0, width: newW, height: newH);
            headerView.frame = frame;
            
        }else {
            headerView.transform = CGAffineTransform(translationX: 0, y: -off);      //上推上移
        }
        
        if off > 0 {//导航条的颜色变化效果 //向上推
            let al = off / 150.0 //透明度
            if al < 1 {
                
                navigationColorView.alpha = al
                
                if al > 0.5 {
                    titleLB.isHidden = false
                }else {
                    titleLB.isHidden = true
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
