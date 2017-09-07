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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "城市列表"
        self.view.backgroundColor = UIColor.white
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
        keyAr = sortAr(keys as NSArray)
    }
    
    func sortAr(_ aArray: NSArray) -> NSArray
    {
        let tempAr = NSMutableArray(array: aArray)
        var tem:String
        for i in 0 ..< tempAr.count - 1 {
            for j in 0 ..< tempAr.count - 1 - i {
                if (tempAr[i] as AnyObject).compare(tempAr[j] as! String) == ComparisonResult.orderedAscending {
                    tem = tempAr.object(at: i) as! String
                    tempAr.replaceObject(at: i, with: aArray[j])
                    tempAr.replaceObject(at: j, with: tem)
                }
            }
        }
        return tempAr
    }
    
    func creatHotCityItem(){
        
        for i in 0 ..< hotCityAr.count {
            let spa = CGFloat(10.0) //间距
            let colNum = CGFloat(3.0) //列数
            let col = CGFloat(i).truncatingRemainder(dividingBy: colNum) //所在的列
            let row = i / Int(colNum) //所在的行
            let btnW = ((self.view.bounds.width) - spa * (colNum + 1)) / colNum //button width
            let btnH = CGFloat(30) //button height
            let btn = UIButton(frame: CGRect(x: (spa + btnW) * col + spa, y: (spa + btnH) * CGFloat(row) + spa, width: btnW, height: btnH))
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(CityListViewController.hotCityBtnAction(_:)), for: UIControlEvents.touchUpInside)
            btn.backgroundColor = UIColor(red: 33.0 / 255.0, green: 192.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitle(hotCityAr[i], for: UIControlState())
            mHotCityView.addSubview(btn)
            
            if i == hotCityAr.count - 1 {
                mHotCityView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: CGFloat(row + 1) * CGFloat(10 + 30) + 10.0)
            }
        }
    }
    
    func hotCityBtnAction(_ btn: UIButton) {
        print("选择了\(btn.titleLabel?.text)")
    }
    
    func creatHotCityView() {
        mHotCityView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        //mHotCityView.backgroundColor = UIColor.grayColor()
    }
    
    func loadTableView() {
        mTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT - 64), style: UITableViewStyle.grouped)
        mTableView.backgroundColor = UIColor.gray
        self.view.addSubview(mTableView)
        
        mTableView.dataSource = self
        mTableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keyAr.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }
        else{
            let key = keyAr[section - 1] as! String
            let ar = cityListDic[key] as! NSArray
            return ar.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
            cell.addSubview(mHotCityView)
        }else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cityCell")
            let key = keyAr[(indexPath.section - 1)] as! String
            let ar = cityListDic[key] as! NSArray
            cell.textLabel?.text = ar[indexPath.row] as? String

        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200.0
        }else {
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let sectionTitle = UILabel(frame: CGRect(x: 10, y: 0, width: 40, height: 30))
        sectionTitle.textAlignment = NSTextAlignment.center
        bgView.addSubview(sectionTitle)
        if section == 0 {
            sectionTitle.text = "热"
        }else {
            sectionTitle.text = keyAr[section - 1] as? String
        }
        
        return bgView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var titleAr = ["热"]
        for i in 0 ..< keyAr.count {
            titleAr.append(keyAr[i] as! String)
        }
        return titleAr
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
        let cell = tableView.cellForRow(at: indexPath)
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
