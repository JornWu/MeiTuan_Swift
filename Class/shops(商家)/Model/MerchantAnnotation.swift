//
//  MerchantAnnotion.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/9/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import Foundation
import MapKit

open class MerchantAnnotation: NSObject, MKAnnotation  {
    
    var merchantDataModel: AM_Rdploc ///外面需要访问

    ///包含在MKAnnotation中
    open var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: Double(merchantDataModel.lat ?? 40), longitude: Double(merchantDataModel.lng ?? 116))/// 空值 ->（40， 116）北京坐标
        }
    }
    
    init(withModel model: AM_Rdploc) {
        merchantDataModel = model
    }
    
//    // Title and subtitle for use by selection UI.
    open var title: String? {
        get {
            return merchantDataModel.name
        }
    }
    
    open var subtitle: String? {
        get {
            return merchantDataModel.addr
        }
    }
    
    
    
    
}
