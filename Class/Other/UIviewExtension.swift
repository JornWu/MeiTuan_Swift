//
//  UIviewExtension.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/16.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func extX() -> CGFloat {
        return self.frame.origin.x
    }
    
    func extY() -> CGFloat {
        return self.frame.origin.y
    }
    
    func extWidth() -> CGFloat {
        return self.frame.size.width
    }
    
    func extHeight() -> CGFloat {
        return self.frame.size.height
    }
    
    func extSize() ->CGSize {
        return self.frame.size
    }
    
    func extOrigin() -> CGPoint {
        return self.frame.origin
    }
    
    func extSetX(x: CGFloat) {
        self.frame.origin = CGPointMake(x, self.extY())
    }
    
    func extSetY(y: CGFloat) {
        self.frame.origin = CGPointMake(self.extX(), y)
    }
    
    func extSetWidth(width: CGFloat) {
        self.frame.size = CGSizeMake(width, self.extHeight())
    }
    
    func extSetHeight(height: CGFloat) {
        self.frame.size = CGSizeMake(self.extWidth(), height)
    }
    
}
