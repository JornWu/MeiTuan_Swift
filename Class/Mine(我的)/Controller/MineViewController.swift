//
//  MineViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class MineViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    
    private var mineTableView: UITableView!
    private var headerBgView: UIView!
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
    
    func creatHeaderView() -> UIView {
        
        headerBgView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 150))
        
        let headerVC = HeaderViewVC(nibName: "HeaderViewVC", bundle: nil)
        let headerView = headerVC.view
        headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 65)//65是xib的最小值
        
        let headerBtn = UIButton(frame: CGRectMake(0, 0, SCREENWIDTH, 65))//用于响应点击事件(多种方式可实现)
        headerBtn.addTarget(self, action: #selector(MineViewController.headerBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        headerBgView.addSubview(headerView)
        headerBgView.addSubview(headerBtn)
        
        
        //个性签名
        let individualityBgView = UIView(frame: CGRectMake(0, headerView.bounds.height + 1, SCREENWIDTH, 150 - 65 - 1))//用于调整文字的显示而加的背景容器，1 是分割线效果
        individualityBgView.backgroundColor = UIColor.whiteColor()
        individualityTextLable = UILabel(frame: CGRectMake(5, 0, SCREENWIDTH - 10, 150 - 65 - 1))
        individualityTextLable.font = UIFont.systemFontOfSize(13)//可以宏固定
        individualityTextLable.textColor = UIColor.orangeColor()
        individualityTextLable.numberOfLines = 0
        individualityTextLable.text = "这个人很懒，什么都没有留下"
        individualityTextLable.backgroundColor = UIColor.whiteColor()
        
        individualityBgView.addSubview(individualityTextLable)
        headerBgView.addSubview(individualityBgView)
        headerBgView.backgroundColor = UIColor.grayColor()
        return headerBgView

    }
    
    func headerBtnAction(btn: UIButton) {
        let detailVC = MineDetailViewController()
        detailVC.view.backgroundColor = UIColor.purpleColor()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
    
/****************************************************************************************************/
/*
** 创建表格
*/

    func processingData() {
        
        let dataAr = DataProcessor.arrayWithPlistFileName.dataArrayWithFileName("MineInformationData.plist")
        for i in 0 ..< dataAr.count {
            let model = MineTableViewCellModel(imageName: dataAr[i]["image"] as! String, title: dataAr[i]["title"] as! String)
            modelAr.append(model)
        }
        
    }
    
    func creatMineTableView() {
        mineTableView = UITableView(frame: CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT), style: UITableViewStyle.Grouped)
        mineTableView.dataSource = self
        mineTableView.delegate = self
        
        mineTableView.registerNib(UINib(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "MineCell")
        
        self.view.addSubview(mineTableView)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelAr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MineTableViewCell.tableViewCellWith(modelAr, tableView: tableView, indexPath: indexPath, reuseIndentify: "MineCell")
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerBgView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150.0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
