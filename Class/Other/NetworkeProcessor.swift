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
    
    static func GET(URLString: NSString, parameters: AnyObject?, progress: ((progress: NSProgress) -> Void)?, success:(task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void, failure: (task: NSURLSessionDataTask?, error: NSError) -> Void) {
        
        
        ///ios 9.0 之前
        //let URLStr = URLString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)//解码，可能包含中文等
        ///iOS 9.0 之后
        //let URLStr = URLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!//解码
        
        ///NSURLSessionConfiguration
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
//        ///AFURLSessionManager   ------(way one)------
//        let manager = AFURLSessionManager(sessionConfiguration: configuration)
//        ///NSURL
//        let Url = NSURL(string: URLStr)
//        ///NSURLRequet
//        let request = NSURLRequest(URL: Url!)
//        
//        ///NSURLSessionDataTask
//        
//        let dataTask = manager.dataTaskWithRequest(request, completionHandler: { (response: NSURLResponse, responseObject: AnyObject?, error: NSError?) -> Void in
//            if ((error) != nil) {
//                print(error)
//            } else {
//                print(response, responseObject)
//            }
//        })
        
        
        ///AFHTTPSessionManager  ------(way two)------
        let httpsManager = AFHTTPSessionManager(sessionConfiguration: configuration)
        
        let security = AFSecurityPolicy.defaultPolicy()
        security.allowInvalidCertificates = true
        security.validatesDomainName = false
        httpsManager.securityPolicy = security
        
        let dataTask = httpsManager.GET(URLString as String, parameters: parameters, progress: progress, success: success, failure: failure)//可以监视进度
        
        
        
        //******************** deprecated ********************//
        
        ///------------分装在内部处理-----------
//        let dataTask = httpManager.GET(URLString, parameters: parameters, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
//            
//                if responseObject != nil {
//                    
//                    print("==========获取的数据==========\n", responseObject!)
//                    
//                }else {
//                    print("-------没有数据！ NO DATA！-------")
//                }
//            
//            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
//                print(error)
//        }

        dataTask!.resume()
        
    }
    
    //////////////////////////
    
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

    

}
