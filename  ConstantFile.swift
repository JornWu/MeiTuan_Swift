//
//   ConstantFile.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/14.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

//import "MJRefresh.h"
//import "MJExtension.h"

import SDWebImage
import AFNetworking


//设备的宽高
public let SCREENHEIGHT = UIScreen.mainScreen().bounds.size.height
public let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width

//经纬度   这里经纬度写死的，真是开发中应该根据定位出来获取到的
public let LATITUDE_DEFAULT = 39.983497
public let LONGITUDE_DEFAULT = 116.318042

//系统版本
public let IOS_VERSION = UIDevice.currentDevice().systemVersion///9.3.1 ///是String

//颜色
public func colorWithRGBA(r: Double, g: Double, b: Double, a: Double) -> UIColor {
    return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a / 1.0))
}
//主题颜色
public let THEMECOLOR = colorWithRGBA(33, g: 192, b: 174, a: 1)
//灰白色的背景
public let BACKGROUNDCOLOR = colorWithRGBA(210, g: 210, b: 210, a: 1)




