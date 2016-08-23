//
//  VisitViewController.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/****************************************************************************************************/
/*
**
** 这是“上门”模块（已经被美团丢弃），通过URL获取的数据将为空或URL失效
**
*/
/****************************************************************************************************/


import UIKit

class VisitViewController: BaseViewController {
    
//    private var visitDataModel: 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        loadVisitData()
        
    }
//    case VisitAd//获取上门广告的数据
//    case VisitService//获取上门服务的数据
//    func loadVisitData() {
        ///上门数据
//        let visitURLString = UrlStrType.VisitService.getUrlString()
//        NetworkeProcessor.GET(recommentURLString, parameters: nil, progress: nil, success: {
////            [unowned self]//捕获列表，避免循环引用
//            (task, responseObject) -> Void in
//            print("----获取数据成功----",responseObject)
//            
////            self.recommentModelWith(responseObject as! NSDictionary)
//            
//            }) { (task, error) -> Void in
//                print("----获取数据失败----",error.localizedDescription)
//                
//        }
        
//        NetworkeProcessor.dataWith(visitURLString, parameters: nil) { (data, reponse, error) -> Void in
//            if error != nil {
//                print(error?.localizedDescription)
//            }else {
//                let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print(str)
//            }
//        }
//    }
 
     
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
