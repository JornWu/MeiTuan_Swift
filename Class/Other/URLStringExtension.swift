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
        let index = URLString.startIndex.advancedBy(4) //swift 2.0+
        let subUrl = URLString.substringFromIndex(index)
        let httpsUrl = httpsHeader + subUrl
        return httpsUrl
    }
}
