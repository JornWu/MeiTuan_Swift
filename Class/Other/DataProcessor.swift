//
//  DataProcessor.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/10.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import Foundation

enum DataProcessor {
    case arrayWithPlistFileName
    case dictionaryWithPlistFileName
    
    func dataArrayWithFileName(aName: String) -> AnyObject {//use NSString is maybe have Multiple type
        switch self {//这里可以用 泛型 <T>，减少代码
        case .arrayWithPlistFileName: let optionArrayWithPlistFileName = {(plistFileName:String)-> NSArray in
            let plistPath = NSBundle.mainBundle().pathForResource(plistFileName, ofType: nil)
            let array = NSArray(contentsOfFile: plistPath!)
            return array!
            }
            return optionArrayWithPlistFileName(aName)
        case .dictionaryWithPlistFileName: let optionDictionaryWithPlistFileName = {(plistFileName:String)-> NSDictionary in
            let plistPath = NSBundle.mainBundle().pathForResource(plistFileName, ofType: nil)
            let dictionary = NSDictionary(contentsOfFile: plistPath!)
            return dictionary!
            }
            return optionDictionaryWithPlistFileName(aName)
            
        }
    }
}
