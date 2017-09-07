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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = THEMECOLOR
    }
    
    func processingData() {
        dataAr = DataProcessor.arrayWithPlistFileName.dataArrayWithFileName("MoreData.plist") as! NSArray
    }
    
    func creatTableView() {
        moreTableView = UITableView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT - 64 - 49), style: UITableViewStyle.grouped)
        self.view.addSubview(moreTableView)
        
        moreTableView.dataSource = self
        moreTableView.delegate = self
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataAr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataAr[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MoreCell")
        cell.textLabel!.text = (dataAr[indexPath.section] as! NSArray)[indexPath.row] as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        if indexPath.section == 0 {
            //二维码扫描
            cell.backgroundColor = THEMECOLOR
        }else if indexPath.section == 2 {
            if indexPath.row == 1 {
                cell.backgroundColor = THEMECOLOR
            }else if indexPath.row == 4 {
                cell.backgroundColor = THEMECOLOR
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {//二维码扫描
            
            self.hidesBottomBarWhenPushed = true
            let QRCodeVC = QRCodeScanViewController()
            self.navigationController?.pushViewController(QRCodeVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            
        }else if indexPath.section == 2 {//支付帮助
            if indexPath.row == 1 {
                self.hidesBottomBarWhenPushed = true
                let urlString = UrlStrType.payHelp.getUrlString()
                self.navigationController?.pushViewController(H5ViewController(urlString: urlString), animated: true)
                self.hidesBottomBarWhenPushed = false
            }else if indexPath.row == 4 {//我要应聘
                self.hidesBottomBarWhenPushed = true
                let urlString = UrlStrType.helpWorking.getUrlString()
                self.navigationController?.pushViewController(H5ViewController(urlString: urlString), animated: true)
                self.hidesBottomBarWhenPushed = false
            }
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
