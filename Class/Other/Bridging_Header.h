//
//  Bridging-Header.h
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/14.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//



#ifndef Bridging_Header_h
#define Bridging_Header_h

@import MJRefresh; ///这是OC文件，用@import引入模块，加逗号
@import AFNetworking;///其实只要在外面用 “import AFNetworking” 导入也是可行的,但并不是所有的库都支持Swift
@import SDWebImage;

///该项目因只是用几个简单功能，所以已改为使用MapKit
///百度地图SDK 查看 BMKVersion.h 版本说明
///API类参考： http://wiki.lbsyun.baidu.com/cms/iossdk/doc/v3_0/html/annotated.html
///使用百度地图的环境配置：http://lbsyun.baidu.com/index.php?title=iossdk/guide/buildproject
///更多使用信息，查看百度地图iOS SDK官方说明：http://lbsyun.baidu.com/index.php?title=iossdk
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//
//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
//
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
//
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
//
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
//
//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
//
//#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#endif /* Bridging_Header_h */
