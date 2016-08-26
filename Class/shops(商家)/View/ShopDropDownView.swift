//
//  ShopDropDownView.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/8/26.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是下拉列表
**
*/
/****************************************************************************************************/


import UIKit

protocol ShopDropDownViewDelegate: NSObjectProtocol {
    func didChoosedFilterType(kindId: Int64)//选择了过滤的类型
    func didChoosedSortType()//选择了排序的类型
}

class ShopDropDownView: UIView, UITableViewDataSource, UITableViewDelegate, ShopViewControllerDelegate {
    weak var delegate: ShopDropDownViewDelegate!
    
    var shopCateListModel: SC_ShopCateListModel!
    private var selectedTypeIndex: Int!
    
    var sortTypeAr = ["智能排序", "好评优先", "离我最近", "人均最低"]//排序类型数值
    
    private var typeChoiceBgView: UIView!
    private var typeChoiceView: UIView!
    private var leftTableView: UITableView!
    private var rightTableView: UITableView!
    private var sortTablewView: UITableView!
    
    convenience init(frame mFrame: CGRect, shopCateListModel model: SC_ShopCateListModel) {
        self.init(frame: mFrame)
        
        
        self.shopCateListModel = model
        self.selectedTypeIndex = 0
        loadAllViews()
    }
    
    func loadAllViews() {
        typeChoiceBgView = UIButton(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 105))///
        typeChoiceBgView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
        self.addSubview(typeChoiceBgView)
        
        typeChoiceView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 300))///
        typeChoiceView.backgroundColor = BACKGROUNDCOLOR
        self.addSubview(typeChoiceView)
        
        leftTableView = UITableView(frame: CGRectMake(0, 0, SCREENWIDTH * 2 / 5, 300), style: UITableViewStyle.Plain)
        leftTableView.tag = 301
        leftTableView.dataSource = self
        leftTableView.delegate = self
        
        rightTableView = UITableView(frame: CGRectMake(SCREENWIDTH * 2 / 5, 0, SCREENWIDTH * 3 / 5, 300), style: UITableViewStyle.Plain)
        rightTableView.tag = 302
        rightTableView.backgroundColor = BACKGROUNDCOLOR
        rightTableView.dataSource = self
        rightTableView.delegate = self
        
        sortTablewView = UITableView(frame: CGRectMake(0, 0, SCREENWIDTH, 300), style: UITableViewStyle.Plain)
        sortTablewView.tag = 303
        sortTablewView.dataSource = self
        sortTablewView.delegate = self
        
        typeChoiceView.addSubview(leftTableView)
        typeChoiceView.addSubview(rightTableView)
        //typeChoiceView.addSubview(sortTablewView)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 301 {
            return shopCateListModel.data.count
        }else if tableView.tag == 302 {
            return shopCateListModel.data[selectedTypeIndex].list.count
        }else {
            return sortTypeAr.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if tableView.tag == 301 {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "LeftCell")
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(11)
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            cell.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
            cell.textLabel!.text = shopCateListModel.data[indexPath.row].name
            cell.detailTextLabel!.text = "\(shopCateListModel.data[indexPath.row].count)"
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(11)
        }else if tableView.tag == 302 {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "RightCell")
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(11)
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            cell.backgroundColor = BACKGROUNDCOLOR
            cell.textLabel!.text = shopCateListModel.data[selectedTypeIndex].list[indexPath.row].name
            cell.detailTextLabel!.text = "\(shopCateListModel.data[selectedTypeIndex].list[indexPath.row].count)"
        }else {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "SortCell")
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(11)
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            cell.imageView?.image  = UIImage(named: "icon_checkbox_unchecked")
            cell.textLabel!.text = sortTypeAr[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if tableView.tag == 301 {
            cell?.textLabel?.textColor = THEMECOLOR
            selectedTypeIndex = indexPath.row
            rightTableView.reloadData()
        }else if tableView.tag == 302 {
            //doing
        }else {
            cell?.textLabel?.textColor = THEMECOLOR
            cell!.imageView?.image  = UIImage(named: "icon_checkbox_checked")
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if tableView.tag == 301 {
            cell?.textLabel?.textColor = UIColor.blackColor()
        }else if tableView.tag == 302 {
            //让代理执行过滤
            if self.delegate?.respondsToSelector(Selector("didChoosedFilterType:")) != nil {
                if shopCateListModel.data[selectedTypeIndex].list != nil {
                    self.delegate.didChoosedFilterType(shopCateListModel.data[selectedTypeIndex].list[indexPath.row].mId)
                }else {
                    self.delegate.didChoosedFilterType(shopCateListModel.data[selectedTypeIndex].mId)
                }
            }
        }else {
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell!.imageView?.image  = UIImage(named: "icon_checkbox_unchecked")
        }
    }
    
    ///ShopViewControllerDelegate
    func didClickChoiceBarButtonItemWith(tag t: Int) {
        //dong
    }
    
    ///ShopViewControllerDelegate
    func didChoiceTheTypeWith(id mId: Int64) {
        //doing
    }
    
    
    
    
/******************************************************************************************************/
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
