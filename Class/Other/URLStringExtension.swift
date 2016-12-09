//
//  URLStringExtension.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/18.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import Foundation

extension String {
    
    static func URLStringHttpToHttps(_ URLString: String) -> String {

        let httpsHeader = "https"
        let range = URLString.range(of: httpsHeader)
        
        if range == nil && URLString.lengthOfBytes(using: String.Encoding.utf8) > 4{ /// 不是https开头
            let index = URLString.characters.index(URLString.startIndex, offsetBy: 4) //swift 2.0+
            let subUrl = URLString.substring(from: index)
            let httpsUrl = httpsHeader + subUrl
            return httpsUrl
        }else {
            return URLString
        }
    }
    
    static func URLStringW_HTo200_120(_ URLString: String) -> String {
        
        let w_hStr = "/w.h/"
        let range = URLString.range(of: w_hStr)
        
        var newString = URLString
        
        if range != nil {
            newString.replaceSubrange(range!, with: "/200.120/")
        }
        
        return newString
    }
}
