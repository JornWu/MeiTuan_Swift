//
//  URLStringExtension.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/18.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import Foundation

extension String {
    
    static func URLStringHttpToHttps(URLString: String) -> String {

        let httpsHeader = "https"
        let range = URLString.rangeOfString(httpsHeader)
        
        if range == nil { /// 不是https开头
            let index = URLString.startIndex.advancedBy(4) //swift 2.0+
            let subUrl = URLString.substringFromIndex(index)
            let httpsUrl = httpsHeader + subUrl
            return httpsUrl
        }else {
            return URLString
        }
    }
    
    static func URLStringW_HTo200_120(URLString: String) -> String {
        
        let w_hStr = "/w.h/"
        let range = URLString.rangeOfString(w_hStr)
        
        var newString = URLString
        
        if range != nil {
            newString.replaceRange(range!, with: "/200.120/")
        }
        
        return newString
    }
}
