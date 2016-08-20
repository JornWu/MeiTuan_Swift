//
//  MoreViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var dataAr: NSArray!
    private var moreTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        processingData()
        creatTableView()
    }
    
    func processingData() {
        dataAr = DataProcessor.arrayWithPlistFileName.dataArrayWithFileName("MoreData.plist") as! NSArray
    }
    
    func creatTableView() {
        moreTableView = UITableView(frame: CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT), style: UITableViewStyle.Grouped)
        self.view.addSubview(moreTableView)
        
        moreTableView.dataSource = self
        moreTableView.delegate = self
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataAr.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAr[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MoreCell")
        cell.textLabel!.text = (dataAr[indexPath.section] as! NSArray)[indexPath.row] as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            //二维码扫描
            
            let QRCodeVC = QRCodeScanViewController()
            self.navigationController?.pushViewController(QRCodeVC, animated: true)
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
