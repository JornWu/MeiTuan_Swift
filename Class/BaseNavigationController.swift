//
//  BaseNavigationController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class BaseNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
     
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        reloadNavigationBar()
    }
    
    func reloadNavigationBar(){

        if Double(UIDevice.current.systemVersion) >= 7.0 {
            self.edgesForExtendedLayout = UIRectEdge()//视图控制器，四条边不指定
            self.extendedLayoutIncludesOpaqueBars = false//不透明的操作栏
            self.modalPresentationCapturesStatusBarAppearance = false
            UINavigationBar.appearance().setBackgroundImage(UIImage(named: ""),
                for: UIBarPosition.top,
                barMetrics:UIBarMetrics.default)
        }
        
        let mainColor = THEMECOLOR
        self.navigationBar.barTintColor = mainColor
        self.navigationBar.tintColor = UIColor.white
        
        //设置标题颜色
        let navigationTitleAttribute = NSDictionary(object: UIColor.black, forKey: NSForegroundColorAttributeName as NSCopying)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
//        let backBtn = UIButton(frame: CGRectMake(0, 0, 40, 40))
//        backBtn.setImage(UIImage(named: "back@2x,png"), forState: UIControlState.Normal)
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backBtn)
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
