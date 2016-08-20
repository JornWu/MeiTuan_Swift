//
//  CreatListViewItemTool.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/11.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class CreatListViewItemTool: NSObject {
    
    ///创建类九宫格列表按钮
    static func creatListViewItemWith(
        count: Int,
        columns: Int,
        itemSize: CGSize,
        xSpace: CGFloat,
        ySpace: CGFloat,
        itemTitle: [String]?,
        titleFont: UIFont?,
        addtag tag: Bool,
        target: AnyObject?,
        action selector: Selector?,
        forControlEvents controlEvents: UIControlEvents?,
        backgroundColor: UIColor?,
        imageForNomals: [UIImage]?,
        imageForHighlighteds: [UIImage]?,
        imageForSelecteds: [UIImage]?,
        parentView: UIView,
        autoResizeParentView: Bool) {
    
        for var i = 0; i < count; i++ {
            
            let col = Int(i % columns) //所在的列
            let row = Int(i / columns) //所在的行
            let bgView = UIView(frame: CGRectMake((xSpace + itemSize.width) * CGFloat(col) + xSpace, (ySpace + itemSize.height) * CGFloat(row) + ySpace, itemSize.width, itemSize.height))
            
            let btn = UIButton(frame: CGRectMake(0, 0, bgView.bounds.width, bgView.bounds.height * 0.8))
            let titleLB = UILabel(frame: CGRectMake(0, btn.bounds.height + 2, bgView.bounds.width, bgView.bounds.height * 0.19))
            titleLB.textAlignment = NSTextAlignment.Center
            bgView.addSubview(btn)
            bgView.addSubview(titleLB)
                
            
            if tag { btn.tag = Int(parentView.frame.origin.x + parentView.frame.origin.y) + i}///tag的计算公式
            if target != nil { btn.addTarget(target, action: selector!, forControlEvents: controlEvents!) }
            if backgroundColor != nil { bgView.backgroundColor = backgroundColor! }
            if imageForNomals != nil { btn.setImage(imageForNomals![i], forState: UIControlState.Normal) }
            if imageForHighlighteds != nil { btn.setImage(imageForHighlighteds![i], forState: UIControlState.Highlighted) }
            if imageForSelecteds != nil { btn.setImage(imageForSelecteds![i], forState: UIControlState.Selected) }
            if titleFont != nil { titleLB.font = titleFont! }
            if itemTitle != nil { titleLB.text = itemTitle![i] }
            
            parentView.addSubview(bgView)
            
            if autoResizeParentView {
                if i == (count - 1) {
                    parentView.bounds = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, CGFloat(row + 1) * CGFloat(ySpace + itemSize.height) + ySpace)
                }
            }
        }
    }
}
