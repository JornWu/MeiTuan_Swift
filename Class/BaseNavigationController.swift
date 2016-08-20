//
//  BaseNavigationController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

//        let mainColor = UIColor(red: 33.0 / 255.0, green: 192.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
//        self.navigationBar.barTintColor = mainColor
//        self.navigationBar.tintColor = UIColor.blueColor()
//        
//        //设置标题颜色
//        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
//        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
//        let mainColor = UIColor(red: 33.0 / 255.0, green: 192.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
//        self.navigationBar.barTintColor = mainColor
//        self.navigationBar.tintColor = UIColor.blueColor()
//        
//        //设置标题颜色
//        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
//        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        let mainColor = UIColor(red: 33.0 / 255.0, green: 192.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
        self.navigationBar.barTintColor = mainColor
        self.navigationBar.tintColor = UIColor.whiteColor()

        //设置标题颜色
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.blackColor(), forKey: NSForegroundColorAttributeName)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        let backBtn = UIButton(frame: CGRectMake(0, 0, 40, 40))
        backBtn.setImage(UIImage(named: "back@2x,png"), forState: UIControlState.Normal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backBtn)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        reloadNavigationBar()
    }
    
    func reloadNavigationBar(){
//        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
//        {
//            self.edgesForExtendedLayout = UIRectEdgeNone;//视图控制器，四条边不指定
//            self.extendedLayoutIncludesOpaqueBars = NO;//不透明的操作栏
//            self.modalPresentationCapturesStatusBarAppearance = NO;
//            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""]
//                forBarPosition:UIBarPositionTop
//                barMetrics:UIBarMetricsDefault];
//        }
//        else
//        {
//            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""]
//                forBarMetrics:UIBarMetricsDefault];
//        }
        if Double(UIDevice.currentDevice().systemVersion) >= 7.0 {
            self.edgesForExtendedLayout = UIRectEdge.None//视图控制器，四条边不指定
            self.extendedLayoutIncludesOpaqueBars = false//不透明的操作栏
            self.modalPresentationCapturesStatusBarAppearance = false
            UINavigationBar.appearance().setBackgroundImage(UIImage(named: ""),
                forBarPosition: UIBarPosition.Top,
                barMetrics:UIBarMetrics.Default)
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
