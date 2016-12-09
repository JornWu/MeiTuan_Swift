//
//  BaseViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy internal var activityIndicatorView: UIView = {///懒加载，并不是所有的view都用到activityIndicatorView
        let AIView = BaseViewController.setupActivutyView()
        self.view.addSubview(AIView)
        return AIView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = BACKGROUNDCOLOR
        self.automaticallyAdjustsScrollViewInsets = false//取消scrollview和tableview上的留白
    }
    
    fileprivate class func setupActivutyView() -> UIView {
        ///封装activityView视图
        let bgView = UIView(frame: CGRect(x: SCREENWIDTH/2-15, y: SCREENHEIGHT/2-15, width: 40, height: 40))
        bgView.tag = 101010 ///要在外面停止
        bgView.backgroundColor = UIColor.gray
        bgView.layer.cornerRadius = 5
        bgView.isHidden = true///默认为隐藏状态
        
        let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))///真正的UIActivityIndicatorView
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()///转动
        ///activityIndicatorView.activityIndicatorViewStyle = .WhiteLarge ///大白色
        activityIndicatorView.color = THEMECOLOR
        
        bgView.addSubview(activityIndicatorView)
        
        return bgView ///
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
