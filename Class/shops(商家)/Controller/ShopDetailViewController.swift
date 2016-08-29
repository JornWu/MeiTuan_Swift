//
//  ShopDetailViewController.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/8/29.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class ShopDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = THEMECOLOR
        
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.frame = CGRectMake(0, 0, 30, 30)
        backBtn.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backBtnAction"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        self.view.backgroundColor = BACKGROUNDCOLOR
    }
    
    func backBtnAction() {
        self.navigationController?.popToRootViewControllerAnimated(true)
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
