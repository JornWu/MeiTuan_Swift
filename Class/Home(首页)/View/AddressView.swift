//
//  AddressView.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/13.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/*
 *******************************************************************************
 *   这是左边选择地址按钮
 *   点击展开的地址视图
 *******************************************************************************
 */

import UIKit

@objc protocol AddressViewDelegate: NSObjectProtocol {
    func listBgViewDidClicked()
    func didClickedButtonWith(_ title: String)
    func didClickedCellIntoCityList()
}

class AddressView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: AddressViewDelegate?
    private var transBgView: UIView! //最底层的容器视图（透明）
    private var areaArray: NSArray!
    private var addressListTableView: UITableView!
    
    var currentCity: String? =  nil {
        didSet {
            let cell = addressListTableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddressDisplayCell
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
        if ((self.delegate?.responds(to: #selector(AddressViewDelegate.listBgViewDidClicked))) != nil) {
            self.delegate!.listBgViewDidClicked()
        }
    }
    
    
    func creatAddressListView() {
        ///transparency background view
        transBgView = UIView(frame: CGRect(x: 0, y: 64, width: self.bounds.width, height: self.bounds.height))
        transBgView.backgroundColor = UIColor.clear
        self.addSubview(transBgView)
        
        ///shadow background buttom(提供阴影和响应事件)
        let listBgView = UIButton(frame: transBgView.bounds)
        listBgView.backgroundColor = UIColor.black
        listBgView.alpha = 0.5
        transBgView.addSubview(listBgView)
        listBgView.addTarget(self, action: #selector(AddressView.listBgButtonAction), for: UIControlEvents.touchUpInside)
        
        ///container view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: listBgView.bounds.width, height: listBgView.bounds.height * 0.5))
        transBgView.addSubview(containerView)
        
        ///address List TableView cell
        addressListTableView = UITableView(frame: CGRect(x: 0, y: containerView.bounds.height - 50, width: listBgView.bounds.width, height: 50), style: UITableViewStyle.plain)
        listBgView.addSubview(addressListTableView)
        addressListTableView.dataSource = self
        addressListTableView.delegate = self
        addressListTableView.rowHeight = 50
        addressListTableView.backgroundColor = UIColor.white
        addressListTableView.isScrollEnabled = false
        containerView.addSubview(addressListTableView)
        
        addressListTableView.register(UINib(nibName: "AddressDisplayCell", bundle: Bundle.main), forCellReuseIdentifier: "addressDisplayCell")
        
        ///address List ScrollView
        let addressListScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: containerView.bounds.width, height: containerView.bounds.height - 50))
        addressListScrollView.backgroundColor = UIColor.white
        containerView.addSubview(addressListScrollView)
        
        ///add button item to scrollView
        let provinceArray = DataProcessor.arrayWithPlistFileName.dataArrayWithFileName("citydata.plist") as! NSArray
        let cityArray = (provinceArray[8] as! NSDictionary)["citylist"]
        if let array = ((cityArray as! NSArray)[0] as! NSDictionary)["arealist"]{
            areaArray = array as! NSArray
        }
        
        for i in 0 ..< areaArray.count {
            let spa = CGFloat(40.0) //间距
            let colNum = CGFloat(3.0) //列数
            let col = CGFloat(i).truncatingRemainder(dividingBy: colNum) //所在的列
            let row = i / Int(colNum) //所在的行
            let btnW = ((addressListScrollView.bounds.width) - spa * (colNum + 1)) / colNum //button width
            let btnH = CGFloat(30) //button height
            let btn = UIButton(frame: CGRect(x: (spa + btnW) * col + spa, y: (spa + btnH) * CGFloat(row) + spa, width: btnW, height: btnH))
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(AddressView.addressBtnAction(_:)), for: UIControlEvents.touchUpInside)
            btn.backgroundColor = UIColor(red: 33.0 / 255.0, green: 192.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitle((areaArray[i] as! Dictionary)["areaName"], for: UIControlState())
            addressListScrollView.addSubview(btn)
            if (i == (areaArray.count - 1)) {
                addressListScrollView.contentSize = CGSize(width: CGFloat(addressListScrollView.bounds.width), height: CGFloat(row + 1) * CGFloat(30 + 40) + CGFloat(40))
            }
        }
        
    }
    
    func addressBtnAction(_ btn: UIButton) {
        let areaName = ((areaArray[btn.tag - 1000] as! NSDictionary)["areaName"]) as? String
        if ((self.delegate?.responds(to: #selector(AddressViewDelegate.didClickedButtonWith(_:)))) != nil){
            self.delegate!.didClickedButtonWith(areaName!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressDisplayCell.tableViewCell(tableView, indexPath: indexPath)
        cell.currentAddressLB.text = currentCity
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ((self.delegate?.responds(to: #selector(AddressViewDelegate.didClickedCellIntoCityList))) != nil) {
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
