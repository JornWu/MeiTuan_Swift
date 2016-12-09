//
//  MineViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class MineViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    
    fileprivate var mineTableView: UITableView!
    fileprivate var headerBgView: UIView!
    var individualityTextLable: UILabel!//个性签名
    var modelAr = [MineTableViewCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ///注意顺序
        processingData()
        creatHeaderView()
        creatMineTableView()
        
        
        //self.view.addSubview(headerView as! UIView)
        
    }
    
    func creatHeaderView() {
        
        headerBgView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
        
        let headerVC = HeaderViewVC(nibName: "HeaderViewVC", bundle: nil)
        let headerView = headerVC.view
        headerView?.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 65)//65是xib的最小值
        
        let headerBtn = UIButton(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 65))//用于响应点击事件(多种方式可实现)
        headerBtn.addTarget(self, action: #selector(MineViewController.headerBtnAction(_:)), for: UIControlEvents.touchUpInside)
        
        headerBgView.addSubview(headerView!)
        headerBgView.addSubview(headerBtn)
        
        
        //个性签名
        let individualityBgView = UIView(frame: CGRect(x: 0, y: (headerView?.bounds.height)! + 1, width: SCREENWIDTH, height: 150 - 65 - 1))//用于调整文字的显示而加的背景容器，1 是分割线效果
        individualityBgView.backgroundColor = UIColor.white
        individualityTextLable = UILabel(frame: CGRect(x: 5, y: 0, width: SCREENWIDTH - 10, height: 150 - 65 - 1))
        individualityTextLable.font = UIFont.systemFont(ofSize: 13)//可以宏固定
        individualityTextLable.textColor = UIColor.orange
        individualityTextLable.numberOfLines = 0
        individualityTextLable.text = "这个人很懒，什么都没有留下"
        individualityTextLable.backgroundColor = UIColor.white
        
        individualityBgView.addSubview(individualityTextLable)
        headerBgView.addSubview(individualityBgView)
        headerBgView.backgroundColor = UIColor.gray
    }
    
    func headerBtnAction(_ btn: UIButton) {
        let detailVC = MineDetailViewController()
        detailVC.view.backgroundColor = UIColor.purple
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
    
/****************************************************************************************************/
/*
** 创建表格
*/

    func processingData() {
        
        let dataAr = DataProcessor.arrayWithPlistFileName.dataArrayWithFileName("MineInformationData.plist") as! NSArray
        for i in 0 ..< dataAr.count {
            let model = MineTableViewCellModel(imageName: (dataAr[i] as! NSDictionary)["image"] as! String, title: (dataAr[i] as! NSDictionary)["title"] as! String)
            modelAr.append(model)
        }
        
    }
    
    func creatMineTableView() {
        mineTableView = UITableView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT - 64 - 49), style: UITableViewStyle.grouped)
        mineTableView.dataSource = self
        mineTableView.delegate = self
        
        mineTableView.register(UINib(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "MineCell")
        
        self.view.addSubview(mineTableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelAr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MineTableViewCell.tableViewCellWith(modelAr, tableView: tableView, indexPath: indexPath, reuseIndentify: "MineCell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerBgView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
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
