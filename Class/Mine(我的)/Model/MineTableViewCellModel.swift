//
//  MineTableViewCellModel.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/14.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class MineTableViewCellModel: NSObject {

    var mImage: UIImage
    var mTitleText: String
    
    init(imageName: String, title: String) {
        mImage = UIImage(named: imageName)!
        mTitleText = title
        super.init()
    }
}
