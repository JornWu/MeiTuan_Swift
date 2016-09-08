//
//  MerchantAnnotion.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/9/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import Foundation
import MapKit

public class MerchantAnnotation: NSObject, MKAnnotation  {
    
    var merchantDataModel: AM_Rdploc

    ///包含在MKAnnotation中
    public var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: Double(merchantDataModel.lat), longitude: Double(merchantDataModel.lng))
        }
    }
    
    init(withModel model: AM_Rdploc) {
        merchantDataModel = model
    }
    
//    // Title and subtitle for use by selection UI.
    public var title: String? {
        get {
            return merchantDataModel.name
        }
    }
    
    public var subtitle: String? {
        get {
            return merchantDataModel.addr
        }
    }
    
    
    
    
}
