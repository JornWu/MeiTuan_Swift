//
//  UIImageExtension.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/9/5.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func cutImage(image img: UIImage, withSize size: CGSize) -> UIImage {
        
        var newSize: CGSize
        
        ///适应图片比例
        if (img.size.width / img.size.height) < (size.width / size.height) {//比例 高过大
            newSize = CGSizeMake(img.size.width, img.size.width * (size.height / size.width))
        }else {//比例 宽过大
            newSize = CGSizeMake(img.size.height * (size.width / size.height), img.size.height)
        }
        
        let imageRef = CGImageCreateWithImageInRect(img.CGImage, CGRectMake(0, 0, newSize.width, newSize.height))

        let newImage = UIImage(CGImage: imageRef!)

        return newImage
        
    }
    
}

