//
//  CityListViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/11.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是地址，城市列表页面
**
*/
/****************************************************************************************************/


import UIKit

class CityListViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    private var mTableView: UITableView!
    private var mHotCityView: UIView!
    private var cityListDic: NSDictionary!
    private var keyAr: NSArray!
    private let hotCityAr = ["广州市", "北京市", "天津市", "西安市", "重庆市", "沈阳市", "青岛市", "济南市", "深圳市", "长沙市", "无锡市"];
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "城市列表"
        self.view.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        processData()
        creatHotCityView()
        creatHotCityItem()
        loadTableView()
    }
    
    func processData(){
        cityListDic = DataProcessor.dictionaryWithPlistFileName.dataArrayWithFileName("citydict.plist") as! NSDictionary
        let keys = cityListDic.allKeys
        keyAr = sortAr(keys)
    }
    
    func sortAr(aArray: NSArray) -> NSArray
    {
        let tempAr = NSMutableArray(array: aArray)
        var tem:String
        for var i = 0; i < tempAr.count - 1; i++ {
            for var j = 0; j < tempAr.count - 1 - i; j++ {
                if tempAr[i].compare(tempAr[j] as! String) == NSComparisonResult.OrderedAscending {
                    tem = tempAr.objectAtIndex(i) as! String
                    tempAr.replaceObjectAtIndex(i, withObject: aArray[j])
                    tempAr.replaceObjectAtIndex(j, withObject: tem)
                }
            }
        }
        return tempAr
    }
    
    func creatHotCityItem(){
        
        for var i = 0; i < hotCityAr.count; i++ {
            let spa = CGFloat(10.0) //间距
            let colNum = CGFloat(3.0) //列数
            let col = CGFloat(i) % colNum //所在的列
            let row = i / Int(colNum) //所在的行
            let btnW = ((self.view.bounds.width) - spa * (colNum + 1)) / colNum //button width
            let btnH = CGFloat(30) //button height
            let btn = UIButton(frame: CGRectMake((spa + btnW) * col + spa, (spa + btnH) * CGFloat(row) + spa, btnW, btnH))
            btn.tag = 1000 + i
            btn.addTarget(self, action: Selector("hotCityBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            btn.backgroundColor = UIColor(red: 33.0 / 255.0, green: 192.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
            btn.titleLabel?.font = UIFont.systemFontOfSize(13)
            btn.setTitle(hotCityAr[i], forState: UIControlState.Normal)
            mHotCityView.addSubview(btn)
            
            if i == hotCityAr.count - 1 {
                mHotCityView.bounds = CGRectMake(0, 0, self.view.bounds.width, CGFloat(row + 1) * CGFloat(10 + 30) + 10.0)
            }
        }
    }
    
    func hotCityBtnAction(btn: UIButton) {
        print("选择了\(btn.titleLabel?.text)")
    }
    
    func creatHotCityView() {
        mHotCityView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 200))
        //mHotCityView.backgroundColor = UIColor.grayColor()
    }
    
    func loadTableView() {
        mTableView = UITableView.init(frame: CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64), style: UITableViewStyle.Grouped)
        mTableView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(mTableView)
        
        mTableView.dataSource = self
        mTableView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keyAr.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }
        else{
            let key = keyAr[section - 1] as! String
            let ar = cityListDic[key] as! NSArray
            return ar.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            cell.addSubview(mHotCityView)
        }else {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cityCell")
            let key = keyAr[(indexPath.section - 1)] as! String
            let ar = cityListDic[key] as! NSArray
            cell.textLabel?.text = ar[indexPath.row] as? String

        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200.0
        }else {
            return 40.0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView(frame: CGRectMake(0, 0, 0, 0))
        let sectionTitle = UILabel(frame: CGRectMake(10, 0, 40, 30))
        sectionTitle.textAlignment = NSTextAlignment.Center
        bgView.addSubview(sectionTitle)
        if section == 0 {
            sectionTitle.text = "热"
        }else {
            sectionTitle.text = keyAr[section - 1] as? String
        }
        
        return bgView
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        var titleAr = ["热"]
        for var i = 0; i < keyAr.count; i++ {
            titleAr.append(keyAr[i] as! String)
        }
        return titleAr
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section != 0 {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        print("选择了\(cell?.textLabel!.text)")
        }
    }

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
