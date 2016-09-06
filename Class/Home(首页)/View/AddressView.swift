//
//  AddressView.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/13.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是左边选择地址按钮
** 点击展开的地址视图
**
*/
/****************************************************************************************************/

import UIKit

@objc protocol AddressViewDelegate: NSObjectProtocol {
    func listBgViewDidClicked()
    func didClickedButtonWith(title: String)
    func didClickedCellIntoCityList()
}

class AddressView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: AddressViewDelegate?
    private var transBgView: UIView! //最底层的容器视图（透明）
    private var areaArray: NSArray!
    private var addressListTableView: UITableView!
    
    var currentCity: String? =  nil {
        didSet {
            let cell = addressListTableView?.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? AddressDisplayCell
            if cell != nil {
            cell!.currentAddressLB.text = currentCity
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        creatAddressListView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func listBgButtonAction() {
        if ((self.delegate?.respondsToSelector(#selector(AddressViewDelegate.listBgViewDidClicked))) != nil) {
            self.delegate!.listBgViewDidClicked()
        }
    }
    
    
    func creatAddressListView() {
        ///transparency background view
        transBgView = UIView(frame: CGRectMake(0, 64, self.bounds.width, self.bounds.height))
        transBgView.backgroundColor = UIColor.clearColor()
        self.addSubview(transBgView)
        
        ///shadow background buttom(提供阴影和响应事件)
        let listBgView = UIButton(frame: transBgView.bounds)
        listBgView.backgroundColor = UIColor.blackColor()
        listBgView.alpha = 0.5
        transBgView.addSubview(listBgView)
        listBgView.addTarget(self, action: #selector(AddressView.listBgButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        ///container view
        let containerView = UIView(frame: CGRectMake(0, 0, listBgView.bounds.width, listBgView.bounds.height * 0.5))
        transBgView.addSubview(containerView)
        
        ///address List TableView cell
        addressListTableView = UITableView(frame: CGRectMake(0, containerView.bounds.height - 50, listBgView.bounds.width, 50), style: UITableViewStyle.Plain)
        listBgView.addSubview(addressListTableView)
        addressListTableView.dataSource = self
        addressListTableView.delegate = self
        addressListTableView.rowHeight = 50
        addressListTableView.backgroundColor = UIColor.whiteColor()
        addressListTableView.scrollEnabled = false
        containerView.addSubview(addressListTableView)
        
        addressListTableView.registerNib(UINib(nibName: "AddressDisplayCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "addressDisplayCell")
        
        ///address List ScrollView
        let addressListScrollView = UIScrollView(frame: CGRectMake(0, 0, containerView.bounds.width, containerView.bounds.height - 50))
        addressListScrollView.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(addressListScrollView)
        
        ///add button item to scrollView
        let provinceArray = DataProcessor.arrayWithPlistFileName.dataArrayWithFileName("citydata.plist")
        let cityArray = provinceArray[8]["citylist"]
        if let array = cityArray!![0]["arealist"]{
            areaArray = array as! NSArray
        }
        
        for i in 0 ..< areaArray.count {
            let spa = CGFloat(40.0) //间距
            let colNum = CGFloat(3.0) //列数
            let col = CGFloat(i) % colNum //所在的列
            let row = i / Int(colNum) //所在的行
            let btnW = ((addressListScrollView.bounds.width) - spa * (colNum + 1)) / colNum //button width
            let btnH = CGFloat(30) //button height
            let btn = UIButton(frame: CGRectMake((spa + btnW) * col + spa, (spa + btnH) * CGFloat(row) + spa, btnW, btnH))
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(AddressView.addressBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            btn.backgroundColor = UIColor(red: 33.0 / 255.0, green: 192.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
            btn.titleLabel?.font = UIFont.systemFontOfSize(13)
            btn.setTitle((areaArray[i] as! Dictionary)["areaName"], forState: UIControlState.Normal)
            addressListScrollView.addSubview(btn)
            if (i == (areaArray.count - 1)) {
                addressListScrollView.contentSize = CGSizeMake(CGFloat(addressListScrollView.bounds.width), CGFloat(row + 1) * CGFloat(30 + 40) + CGFloat(40))
            }
        }
        
    }
    
    func addressBtnAction(btn: UIButton) {
        let areaName = (areaArray[btn.tag - 1000]["areaName"]) as? String
        if ((self.delegate?.respondsToSelector(#selector(AddressViewDelegate.didClickedButtonWith(_:)))) != nil){
            self.delegate!.didClickedButtonWith(areaName!)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = AddressDisplayCell.tableViewCell(tableView, indexPath: indexPath)
        cell.currentAddressLB.text = currentCity
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if ((self.delegate?.respondsToSelector(#selector(AddressViewDelegate.didClickedCellIntoCityList))) != nil) {
            self.delegate?.didClickedCellIntoCityList()
        }
    }
    

    
    
    
/****************************************************************************************************/

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
