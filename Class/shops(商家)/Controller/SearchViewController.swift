//
//  SearchViewController.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/8/24.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private var searchField: UITextField!
    
    private lazy var hotWords: [String] = {
        return ["外卖", "华莱士", "正新鸡排", "麦当劳", "华德莱", "知味观", "可莎蜜儿", "毛源昌眼镜店", "必胜客", "肯德基", "兰州拉面", "川味坊"]
    }()
    
    private var hotListView: UIView!
    
    private var searchTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BACKGROUNDCOLOR

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupHotListView()
        setupSearchTableView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = THEMECOLOR
        searchField.hidden = true///隐藏
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchField.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        searchField.resignFirstResponder()
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.frame = CGRectMake(0, 0, 25, 25)
        backBtn.setImage(UIImage(named: "btn_backItem"), forState: UIControlState.Normal)
        backBtn.setImage(UIImage(named: "btn_backItem.highlighted"), forState: UIControlState.Highlighted)
        backBtn.addTarget(self, action: #selector(SearchViewController.backBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        ///search test field
        searchField = UITextField(frame: CGRectMake(60, 9, SCREENWIDTH - 30 - 50, 25))
        searchField.clipsToBounds = true
        searchField.layer.cornerRadius = searchField.extHeight() * 0.5
        searchField.borderStyle = .None
        searchField.backgroundColor = BACKGROUNDCOLOR
        
        let lView = UIImageView(frame: CGRectMake(5, 5, 15, 15))
        lView.image = UIImage(named: "icon_textfield_search")
        let lBgView = UIView(frame: CGRectMake(0, 0, 25, 25))
        lBgView.addSubview(lView)
        searchField.leftView = lBgView
        searchField.leftViewMode = .Always
        
        searchField.clearButtonMode = .WhileEditing
        searchField.clearsOnInsertion = true
        
        searchField.placeholder = "输入商家、品类、商圈"
        searchField.font = UIFont.systemFontOfSize(12)
        self.navigationController?.navigationBar.addSubview(searchField)
        
        searchField.delegate = self
    }
    
    func backBtnAction() {
        searchField.resignFirstResponder()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func setupSearchTableView() {
        searchTableView = UITableView(frame: CGRectMake(0, 62, SCREENWIDTH, SCREENHEIGHT - 64), style: .Grouped)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        self.view.addSubview(searchTableView)
        
    }
    
    func setupHotListView() {
        
        hotListView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 150))
        hotListView.backgroundColor = UIColor.grayColor()
        
        for index in 0 ..< hotWords.count {
            let itemBtn = UIButton(type: .Custom)
            
            let tc = 3 //总3列
            let tr = Int(hotWords.count / 3)//总行
            
            let c  = CGFloat(index % tc)
            let r = Int(index / tc)
            let w = (SCREENWIDTH - 2) / 3
            let h = (150 - 2) / tr
            
            itemBtn.frame = CGRectMake((w + 1) * c, (CGFloat(h) + 1) * CGFloat(r), w, CGFloat(h))
            itemBtn.backgroundColor = UIColor.whiteColor()
            itemBtn.setTitle(hotWords[index], forState: .Normal)
            itemBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            itemBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
            itemBtn.tag = index + 500
            itemBtn.addTarget(self, action: #selector(itemAction(_:)), forControlEvents: .TouchUpInside)
            hotListView.addSubview(itemBtn)
        }
    }
    
    func itemAction(btn: UIButton) {
        ///doing
        searchField.resignFirstResponder()
        print("点击了tag为\(btn.tag)的按钮")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.contentView.addSubview(hotListView)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001 ///0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let sBgView = UIView(frame: CGRectMake(0, 0, SCREENWIDTH, 30))
            let titleLabel = UILabel(frame: CGRectMake(10 , 0, SCREENWIDTH - 10, 30))
            titleLabel.text = "热门搜索"
            titleLabel.font = UIFont.systemFontOfSize(13)
            titleLabel.textColor = UIColor.grayColor()
            
            sBgView.addSubview(titleLabel)
            
            return sBgView
        }else {
            return nil
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
