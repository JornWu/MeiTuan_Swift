//
//  NetworkeProcessor.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/15.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit
import SDWebImage
import AFNetworking

struct NetworkeProcessor {
    
    ///GET,AFNetworking
    static func GET(URLString: NSString, parameters: AnyObject?, progress: ((progress: NSProgress) -> Void)?, success:(task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void, failure: (task: NSURLSessionDataTask?, error: NSError) -> Void) {
        
        ///ios 9.0 之前
        //let URLStr = URLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)//解码，可能包含中文等
        ///iOS 9.0 之后
        //let URLStr = URLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!//解码
        
        ///NSURLSessionConfiguration
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        ///AFHTTPSessionManager
        let httpsManager = AFHTTPSessionManager(sessionConfiguration: configuration)
        
        let security = AFSecurityPolicy.defaultPolicy()
        security.allowInvalidCertificates = true
        security.validatesDomainName = false
        httpsManager.securityPolicy = security
        
        let dataTask = httpsManager.GET(URLString as String, parameters: parameters, progress: progress, success: success, failure: failure)//可以监视进度

        dataTask!.resume()
        
    }
    
    ///POST,非AFNetworking
    static func dataWith(URLString: NSString, parameters: AnyObject?, completionHandler hander: (NSData?, NSURLResponse?, NSError?) -> Void) {
        
        let URLStr = URLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!//编码
        
        ///NSURLSessionConfiguration
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        ///AFURLSessionManager   ------(way one)------
        let session = NSURLSession(configuration: configuration)
        ///NSURL
        let Url = NSURL(string: URLStr)
        ///NSURLRequet
        let request = NSMutableURLRequest(URL: Url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 6)
        //NSURLRequest(URL: Url!)
        request.HTTPMethod = "POST"

        ///NSURLSessionDataTask
        let dataTask = session.dataTaskWithRequest(request, completionHandler: hander)
        
        dataTask.resume()
    }
    
    
    
    
    /*
     系统同时提供了几种并发队列。这些队列和它们自身的QoS等级相关。QoS等级表示了提交任务的意图，使得GCD可以决定如何制定优先级。
     
     QOS_CLASS_USER_INTERACTIVE： user interactive 等级表示任务需要被立即执行以提供好的用户体验。使用它来更新UI，
     响应事件以及需要低延时的小工作量任务。这个等级的工作总量应该保持较小规模。
     QOS_CLASS_USER_INITIATED：   user initiated 等级表示任务由UI发起并且可以异步执行。它应该用在用户需要即时
     的结果同时又要求可以继续交互的任务。
     QOS_CLASS_UTILITY：         utility 等级表示需要长时间运行的任务，常常伴随有用户可见的进度指示器。
     使用它来做计算，I/O，网络，持续的数据填充等任务。这个等级被设计成节能的。
     QOS_CLASS_BACKGROUND：       background 等级表示那些用户不会察觉的任务。使用它来执行预加载，
     维护或是其它不需用户交互和对时间不敏感的任务。
     */
    
    ///封装的子线程异步加载网络数据方法
    static func loadNetworkeDate(withTarget target: UIViewController, URLString: String, result: (dictionary: NSDictionary) -> Void) {
        ///加载数据很耗时，放到子线程中
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) { () -> Void in
            NetworkeProcessor.GET(URLString, parameters: nil, progress: {
                [unowned target]
                (progress: NSProgress) in
                
                let activityView = UIActivityIndicatorView(frame: CGRectMake(SCREENWIDTH/2-15, SCREENHEIGHT/2-15, 30, 30))
                activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                activityView.hidesWhenStopped = true
                activityView.startAnimating()///转动
                target.view.addSubview(activityView)
                target.view.bringSubviewToFront(activityView)
                
                if progress.fractionCompleted == 1 {//下载完成
                    activityView.stopAnimating()///停止
                }
                
                }, success: {
                    (task: NSURLSessionDataTask, responseObject: AnyObject?) in
                    //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
                    
                    ///返回主线程刷新UI
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        result(dictionary: responseObject as! NSDictionary)
                    })
                    
                }, failure: {(task: NSURLSessionDataTask?, responseObject: AnyObject)in
                    print("----获取数据失败----",responseObject)
            })
        }
    }
}
