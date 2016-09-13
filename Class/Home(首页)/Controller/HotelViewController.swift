//
//  HotelViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/20.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是店面详情视图
**
*/
/****************************************************************************************************/


import UIKit

class HotelViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataModel: RE_Data!
    private var hotelTableView: UITableView!
    private var hotelDetailModel: HD_HotelDetailModel!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    convenience init(dataModel model: RE_Data) {
        self.init()
    
        self.dataModel = model
        self.view.backgroundColor = BACKGROUNDCOLOR
        
        self.title = "团购详情"
        let backBtn = UIButton(frame: CGRectMake(0, 0, 30, 30))
        backBtn.setImage(UIImage(named: "back@2x.png"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: #selector(HotelViewController.backBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        loadOtherHotelData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    func backBtnAction() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func loadOtherHotelData() {
        self.view.bringSubviewToFront(self.activityIndicatorView)
        self.activityIndicatorView.hidden = false ///让activityView显示
        
        let URLString = UrlStrType.urlStringWithOtherRecommendShop("\(dataModel.mId)")
        ///封装的方法
        NetworkeProcessor.loadNetworkeDate(withTarget: self, URLString: URLString) {
            [unowned self]
            (dictionary) in
            self.hotelModelWith(dictionary)
            self.activityIndicatorView.hidden = true ///让activityView隐藏
        }
        
    }
    
    func hotelModelWith(dictionary: NSDictionary) {
        hotelDetailModel = HD_HotelDetailModel(fromDictionary: dictionary)
        creatHotelDetailTableView()
    }
    
    func creatHotelDetailTableView() {
        hotelTableView = UITableView(frame: CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64), style: UITableViewStyle.Grouped)
        //cell 相同
        hotelTableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HotelCell")//从xib加载
        
        hotelTableView.dataSource = self
        hotelTableView.delegate = self
        self.view.insertSubview(hotelTableView, atIndex: 0)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else {
            return hotelDetailModel.data.deals.count + 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                let headerImageView = UIImageView(frame: CGRectMake(0, 0, SCREENWIDTH, 150))
                headerImageView.sd_setImageWithURL(NSURL(string: dataModel.imgurl), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
                cell.addSubview(headerImageView)
                return cell
            }else if indexPath.row == 1 {
                
                ///只有一个，直接从xib中加载
                let cell = NSBundle.mainBundle().loadNibNamed("HotelPriceCell", owner: nil, options: nil).last as! HotelPriceCell
                cell.priceLB.text = "\(dataModel.price)"
                cell.priceLB.font = UIFont.systemFontOfSize(40)
                cell.valueLB.textAlignment = .Left
                
                cell.valueLB.text = "门市价: ￥" + "\(dataModel.value)"
                cell.valueLB.font = UIFont.systemFontOfSize(15)
                cell.valueLB.textAlignment = .Left
                
                cell.selectionStyle = .None
                
                return cell
            }else {
                let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
                cell.accessoryType = .DisclosureIndicator
                cell.selectionStyle = .None
                
                if dataModel.rating != nil && dataModel.ratecount != nil {
                    
                    let starView = StarView(withRate: CGFloat(dataModel.rating), total: 5, starWH: 30, space: 3,starImageFull: UIImage(named: "icon_merchant_star_full")!, starImageEmpty: UIImage(named: "icon_merchant_star_empty")!)
                    
                    starView.extSetY((cell.contentView.extHeight() - starView.extHeight()) / 2)
                    cell.contentView.addSubview(starView)
                    
                    cell.detailTextLabel?.text = "\(dataModel.ratecount)" + "人评价"
                }else {
                    cell.textLabel?.text = "暂无评分"
                    cell.textLabel?.font = UIFont.systemFontOfSize(20)
                }

                
                return cell
            }
            
        }else {
            
            if indexPath.row == 0 {
                
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                cell.textLabel?.text = hotelDetailModel.data.title
                return cell
                
            }else {
                let cell = HomeTableViewCell.creatCellWith(tableView, indexPath: indexPath, reuseIdentifier: "HotelCell") as HomeTableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                
                let dealModel = hotelDetailModel.data.deals[indexPath.row - 1]
                
                cell.ImageView.sd_setImageWithURL(NSURL(string: dealModel.imgurl), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
                cell.titleLB.text = dealModel.brandname
                cell.detailLB.text = "[" + dealModel.range + "]" + dealModel.title
                cell.priceLB.text = "\(dealModel.price)" + "元"
                cell.priceLB.textColor = THEMECOLOR
                
                cell.valueLB.text = "门面价：" + "\(dealModel.value)" + "元"
                cell.valueLB.textColor = UIColor.grayColor()
                cell.salesLB.text = "已卖" + "\(dealModel.solds)" + "份"
                cell.salesLB.textColor = THEMECOLOR
                return cell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 150
            }else if indexPath.row == 1 {
                return 60
            }else {
                return 50
            }
            
        }else {
            if indexPath.row == 0 {
                return 30
            }else {
                return 126
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row != 0 {
                let dealItem = hotelDetailModel.data.deals[indexPath.row - 1]
                let dealDictionary = dealItem.toDictionary()
                let dataItem = RE_Data(fromDictionary: dealDictionary)
                
                let HTVC = HotelViewController(dataModel: dataItem)
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(HTVC, animated: true)
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001 //0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001 //0
        }else {
            return 20
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
