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
        
        let backBtn = UIButton(frame: CGRectMake(0, 0, 30, 30))
        backBtn.setImage(UIImage(named: "back@2x.png"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backBtnAction"), forControlEvents: UIControlEvents.TouchUpInside)
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
        
        let URLString = UrlStrType.urlStringWithOtherRecommendShop("\(dataModel.mId)")
        
        NetworkeProcessor.GET(URLString, parameters: nil, progress: nil, success: {
            [unowned self]//捕获列表，避免循环引用
            (task, responseObject) -> Void in
            //print("----获取数据成功----",responseObject)
            
            self.hotelModelWith(responseObject as! NSDictionary)
            
            }) { (task, error) -> Void in
                print("----获取数据失败----",error.localizedDescription)
                
        }
        
    }
    
    func hotelModelWith(dictionary: NSDictionary) {
        hotelDetailModel = HD_HotelDetailModel(fromDictionary: dictionary)
        creatHotelDetailTableView()
    }
    
    func creatHotelDetailTableView() {
        hotelTableView = UITableView(frame: CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49), style: UITableViewStyle.Plain)
        //cell 相同
        hotelTableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HotelCell")//从xib加载
        
        hotelTableView.dataSource = self
        hotelTableView.delegate = self
        self.view.addSubview(hotelTableView)
        
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
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                //.cell.textLabel?.text = hotelDetailModel.data.title
                return cell
            }else {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                //cell.textLabel?.text = hotelDetailModel.data.title
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
                
                cell.ImageView.sd_setImageWithURL(NSURL(), placeholderImage: UIImage(named: "bg_merchant_photo_placeholder_big@2x.png"))
                cell.titleLB.text = dealModel.brandname
                cell.detailLB.text = "[" + dealModel.range + "]" + dealModel.title
                cell.priceLB.text = "\(dealModel.price)" + "元"
                cell.priceLB.textColor = THEMECOLOR
                
                cell.valueLB.text = "门面价：" + "\(dealModel.value)" + "元"
                cell.valueLB.textColor = UIColor.grayColor()
                cell.salesLB.text = "已卖" + "\(dealModel.solds)" + "份"
                cell.salesLB.textColor = UIColor.redColor()
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
                self.navigationController?.pushViewController(HTVC, animated: true)
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
