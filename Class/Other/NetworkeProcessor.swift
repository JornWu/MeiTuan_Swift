//
//  NetworkeProcessor.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/15.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit
import Foundation

struct NetworkeProcessor {
    
    ///GET,AFNetworking
    static func GET(_ URLString: NSString, parameters: AnyObject?, progress: ((_ progress: Progress) -> Void)?, success:@escaping (_ task: URLSessionDataTask, _ responseObject: Any?) -> Void, failure:@escaping (_ task: URLSessionDataTask?, _ error: Error) -> Void) {
        
        ///ios 9.0 之前
        //let URLStr = URLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)//解码，可能包含中文等
        ///iOS 9.0 之后
        //let URLStr = URLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!//解码
        
        let configuration = URLSessionConfiguration.default
        let httpsManager = AFHTTPSessionManager(sessionConfiguration: configuration)
        
        let security = AFSecurityPolicy.default()///安全策略
        security.allowInvalidCertificates = true
        security.validatesDomainName = false
        httpsManager.securityPolicy = security
        
        ///httpsManager.responseSerializer = AFHTTPResponseSerializer()
        ///添加这行代码，获得的数据将是二进制形式，然后再转成想要的格式
        ///默认会自动转为相应的格式，如Dictionary
        
        httpsManager.requestSerializer.timeoutInterval = 15///超时时长
        
        let dataTask = httpsManager.get(URLString as String,
                                        parameters: parameters,
                                        progress: progress,
                                        success: success,
                                        failure: failure)//可以监视进度

        dataTask!.resume()
        
    }
    
    ///GET,非AFNetworking
    static func dataWith(_ URLString: NSString, parameters: AnyObject?, completionHandler hander: @escaping (URLResponse, Any?, Error?)->Void) {
        let URLStr = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!//编码
        let configuration = URLSessionConfiguration.default
        let session = AFURLSessionManager(sessionConfiguration: configuration)
        let Url = URL(string: URLStr)
        let request = NSMutableURLRequest(url: Url!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 6)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        ////当然还可以添加更多参数（来自parameters）///request.setValue(<#T##value: AnyObject?##AnyObject?#>, forKey: <#T##String#>)

        ///NSURLSessionDataTask
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: hander)
        
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
    
    ///自封装
    static func loadNetworkeDate(withTarget target: UIViewController, URLString: String, result: @escaping (_ dictionary: NSDictionary) -> Void) {
        ///封装放到子线中去
        DispatchQueue.global(qos: .utility).async {

            NetworkeProcessor.GET(URLString as NSString, parameters: nil, progress: {
                (progress: Progress) in ///想了解progress的进度，可以用KVO来监视，但是这里不能再Struct中实现，要放在@objc class中
                    ///doing 
                }, success: {
                    (task: URLSessionDataTask, responseObject: Any?) in
                    //print("----获取数据成功----",responseObject)//responseObject 已经是一个字典对象了
                
                    ///返回主线程刷新UI
                    DispatchQueue.main.async(execute:
                        { result(responseObject as! NSDictionary) }///闭包回调
                    )
                    
                }, failure: {(task: URLSessionDataTask?, responseObject: Error)in
                    print("----获取数据失败----",responseObject.localizedDescription)
            })
        }
    }
}
