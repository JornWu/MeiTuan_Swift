//
//  SearchViewController.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/8/24.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate var searchField: UITextField!
    
    fileprivate lazy var hotWords: [String] = {
        return ["外卖", "华莱士", "正新鸡排", "麦当劳", "华德莱", "知味观", "可莎蜜儿", "毛源昌眼镜店", "必胜客", "肯德基", "兰州拉面", "川味坊"]
    }()
    
    fileprivate var hotListView: UIView!
    
    fileprivate var searchTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BACKGROUNDCOLOR

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupHotListView()
        setupSearchTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = THEMECOLOR
        searchField.isHidden = true///隐藏
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchField.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchField.resignFirstResponder()
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backBtn.setImage(UIImage(named: "btn_backItem"), for: UIControlState())
        backBtn.setImage(UIImage(named: "btn_backItem.highlighted"), for: UIControlState.highlighted)
        backBtn.addTarget(self, action: #selector(SearchViewController.backBtnAction), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        ///search test field
        searchField = UITextField(frame: CGRect(x: 60, y: 9, width: SCREENWIDTH - 30 - 50, height: 25))
        searchField.clipsToBounds = true
        searchField.layer.cornerRadius = searchField.extHeight() * 0.5
        searchField.borderStyle = .none
        searchField.backgroundColor = BACKGROUNDCOLOR
        
        let lView = UIImageView(frame: CGRect(x: 5, y: 5, width: 15, height: 15))
        lView.image = UIImage(named: "icon_textfield_search")
        let lBgView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        lBgView.addSubview(lView)
        searchField.leftView = lBgView
        searchField.leftViewMode = .always
        
        searchField.clearButtonMode = .whileEditing
        searchField.clearsOnInsertion = true
        
        searchField.placeholder = "输入商家、品类、商圈"
        searchField.font = UIFont.systemFont(ofSize: 12)
        self.navigationController?.navigationBar.addSubview(searchField)
        
        searchField.delegate = self
    }
    
    func backBtnAction() {
        searchField.resignFirstResponder()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupSearchTableView() {
        searchTableView = UITableView(frame: CGRect(x: 0, y: 62, width: SCREENWIDTH, height: SCREENHEIGHT - 64), style: .grouped)
        searchTableView.dataSource = self
        searchTableView.delegate = self
        self.view.addSubview(searchTableView)
        
    }
    
    func setupHotListView() {
        
        hotListView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 150))
        hotListView.backgroundColor = UIColor.gray
        
        for index in 0 ..< hotWords.count {
            let itemBtn = UIButton(type: .custom)
            
            let tc = 3 //总3列
            let tr = Int(hotWords.count / 3)//总行
            
            let c  = CGFloat(index % tc)
            let r = Int(index / tc)
            let w = (SCREENWIDTH - 2) / 3
            let h = (150 - 2) / tr
            
            itemBtn.frame = CGRect(x: (w + 1) * c, y: (CGFloat(h) + 1) * CGFloat(r), width: w, height: CGFloat(h))
            itemBtn.backgroundColor = UIColor.white
            itemBtn.setTitle(hotWords[index], for: UIControlState())
            itemBtn.setTitleColor(UIColor.black, for: UIControlState())
            itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            itemBtn.tag = index + 500
            itemBtn.addTarget(self, action: #selector(itemAction(_:)), for: .touchUpInside)
            hotListView.addSubview(itemBtn)
        }
    }
    
    func itemAction(_ btn: UIButton) {
        ///doing
        searchField.resignFirstResponder()
        print("点击了tag为\(btn.tag)的按钮")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.contentView.addSubview(hotListView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001 ///0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let sBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 30))
            let titleLabel = UILabel(frame: CGRect(x: 10 , y: 0, width: SCREENWIDTH - 10, height: 30))
            titleLabel.text = "热门搜索"
            titleLabel.font = UIFont.systemFont(ofSize: 13)
            titleLabel.textColor = UIColor.gray
            
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
