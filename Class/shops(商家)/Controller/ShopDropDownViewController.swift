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

@objc protocol ShopDropDownViewControllerDelegate: NSObjectProtocol {
    func didChoosedFilterType(_ kindId: Int, kindName: String)//选择了过滤的类型
    func didChoosedSortType()//选择了排序的类型
    func didRevertDropDownViewState()//恢复下拉视图的状态
}

class ShopDropDownViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, ShopViewControllerDelegate {
    weak var delegate: ShopDropDownViewControllerDelegate!
    
    var shopCateListModel: SC_ShopCateListModel!
    fileprivate var selectedTypeIndex: Int!
    
    var sortTypeAr = ["智能排序", "好评优先", "离我最近", "人均最低"]//排序类型数值
    
    fileprivate var typeChoiceView: UIView!
    fileprivate var leftTableView: UITableView!
    fileprivate var rightTableView: UITableView!
    fileprivate var sortTablewView: UITableView!
    fileprivate var currentSelectedItemTag: Int?
    
    convenience init(withFrame frame: CGRect, shopCateListModel: SC_ShopCateListModel) {
        self.init()
        setupViewWith(frame: frame, shopCateListModel: shopCateListModel)
    }
    
    override func viewDidLoad() {
        ///doing
    }
    
    func setupViewWith(frame mFrame: CGRect, shopCateListModel model: SC_ShopCateListModel) {
        self.view.frame = mFrame
        self.shopCateListModel = model
        self.selectedTypeIndex = 0
        loadAllViews()
        self.view.isHidden = true ///默认为隐藏的
    }
    
    func loadAllViews() {
        let typeChoiceBgView = UIButton(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 105))///
        typeChoiceBgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        typeChoiceBgView.addTarget(self, action: #selector(ShopDropDownViewController.revertDropDownView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(typeChoiceBgView)
        
        typeChoiceView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 300))///
        typeChoiceView.backgroundColor = BACKGROUNDCOLOR
        self.view.addSubview(typeChoiceView)
        
        leftTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH * 2 / 5, height: 300), style: UITableViewStyle.plain)
        leftTableView.tag = 301
        leftTableView.dataSource = self
        leftTableView.delegate = self
        
        rightTableView = UITableView(frame: CGRect(x: SCREENWIDTH * 2 / 5, y: 0, width: SCREENWIDTH * 3 / 5, height: 300), style: UITableViewStyle.plain)
        rightTableView.tag = 302
        rightTableView.backgroundColor = BACKGROUNDCOLOR
        rightTableView.dataSource = self
        rightTableView.delegate = self
        
        sortTablewView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 160), style: UITableViewStyle.plain)
        sortTablewView.tag = 303
        sortTablewView.rowHeight = 40
        sortTablewView.isHidden = true
        sortTablewView.dataSource = self
        sortTablewView.delegate = self
        
        typeChoiceView.addSubview(leftTableView)
        typeChoiceView.addSubview(rightTableView)
        typeChoiceView.addSubview(sortTablewView)
    }
    
    func revertDropDownView() {
        self.view.isHidden = true
        if self.delegate?.responds(to: #selector(ShopDropDownViewControllerDelegate.didRevertDropDownViewState)) != nil {
            self.delegate?.didRevertDropDownViewState()///恢复所有选择按钮的状态
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 301 {
            return shopCateListModel.data.count
        }else if tableView.tag == 302 {
            return shopCateListModel.data[selectedTypeIndex].list.count
        }else {
            return sortTypeAr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if tableView.tag == 301 {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "LeftCell")
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
            cell.detailTextLabel?.textColor = UIColor.gray
            cell.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
            cell.textLabel!.text = shopCateListModel.data[indexPath.row].name
            cell.detailTextLabel!.text = "\(shopCateListModel.data[indexPath.row].count!)"
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
        }else if tableView.tag == 302 {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "RightCell")
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
            cell.detailTextLabel?.textColor = UIColor.gray
            cell.backgroundColor = BACKGROUNDCOLOR
            cell.textLabel!.text = shopCateListModel.data[selectedTypeIndex].list[indexPath.row].name
            cell.detailTextLabel!.text = "\(shopCateListModel.data[selectedTypeIndex].list[indexPath.row].count!)"
        }else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SortCell")
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
            cell.detailTextLabel?.textColor = UIColor.gray
            cell.imageView?.image  = UIImage(named: "icon_checkbox_unchecked")
            cell.textLabel!.text = sortTypeAr[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if tableView.tag == 301 {
            if indexPath.row == 0 {///全部
                //让代理执行过滤
                if self.delegate?.responds(to: #selector(ShopDropDownViewControllerDelegate.didChoosedFilterType(_: kindName:))) != nil {
                    
                    self.delegate?.didChoosedFilterType(shopCateListModel.data[0].mId, kindName: shopCateListModel.data[0].name)
                }
                cell?.textLabel?.textColor = THEMECOLOR
                selectedTypeIndex = indexPath.row
                rightTableView.reloadData()
                revertDropDownView()///恢复拉视图
            }else {
                cell?.textLabel?.textColor = THEMECOLOR
                selectedTypeIndex = indexPath.row
                rightTableView.reloadData()
            }
        }else if tableView.tag == 302 {
            //让代理执行过滤
            if self.delegate?.responds(to: #selector(ShopDropDownViewControllerDelegate.didChoosedFilterType(_: kindName:))) != nil {
                if shopCateListModel.data[selectedTypeIndex].list != nil {
                    self.delegate?.didChoosedFilterType(shopCateListModel.data[selectedTypeIndex].list[indexPath.row].mId, kindName: shopCateListModel.data[selectedTypeIndex].list[indexPath.row].name)
                }else {
                    self.delegate?.didChoosedFilterType(shopCateListModel.data[selectedTypeIndex].mId, kindName: shopCateListModel.data[selectedTypeIndex].name)
                }
            }
            revertDropDownView()///恢复拉视图
            
        }else {
            cell?.textLabel?.textColor = THEMECOLOR
            cell!.imageView?.image  = UIImage(named: "icon_checkbox_checked")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if tableView.tag == 301 {
            cell?.textLabel?.textColor = UIColor.black
        }else if tableView.tag == 302 {
            //////
        }else {
            cell?.textLabel?.textColor = UIColor.black
            cell!.imageView?.image  = UIImage(named: "icon_checkbox_unchecked")
        }
    }
    
    ///ShopViewControllerDelegate
    func didClickChoiceBarButtonItemWith(button btn: UIButton) {
        
        if currentSelectedItemTag == nil {///从关闭中展开
            currentSelectedItemTag = btn.tag
        }else if currentSelectedItemTag != btn.tag {///从展开中切换
            self.view.isHidden = false///先把前面的关闭
        }
        
        switch btn.tag {
        case 200:///类型筛选选择
            typeChoiceView.extSetHeight(300)
            self.typeChoiceView.extSetY(-1 * self.typeChoiceView.extHeight())
            btn.isSelected = !btn.isSelected
            self.view.isHidden = !self.view.isHidden
            if btn.isSelected {///展开
                
                sortTablewView.isHidden = true
                leftTableView.isHidden = false
                rightTableView.isHidden = false
                
                UIView.animate(withDuration: 0.2, animations: {
                    [unowned self]
                    () -> Void in
                    
                    self.typeChoiceView.transform = self.typeChoiceView.transform.translatedBy(x: 0, y: self.typeChoiceView.extHeight())
                    }, completion: { (isCompletion) -> Void in
                        
                        if isCompletion {
                            // 加载那个数据
                        }
                })
            }else {///关闭
                currentSelectedItemTag = nil
            }
            
        case 201:///地区筛选选择
            self.view.isHidden = false
            
            // doing
            
        case 202:///排序类型选择
            btn.isSelected = !btn.isSelected
            self.view.isHidden = !self.view.isHidden
            
            if btn.isSelected {
                
                typeChoiceView.extSetHeight(160)
                self.typeChoiceView.extSetY(-1 * self.typeChoiceView.extHeight())
                self.view.isHidden = false
                leftTableView.isHidden = true
                rightTableView.isHidden = true
                sortTablewView.isHidden = false
                
                UIView.animate(withDuration: 0.2, animations: {
                    [unowned self]
                    () -> Void in
                    self.typeChoiceView.transform = self.typeChoiceView.transform.translatedBy(x: 0, y: self.typeChoiceView.extHeight())
                    })
            }else {
                currentSelectedItemTag = nil
            }
            
            
            
        default:/// other
            break
        }
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
