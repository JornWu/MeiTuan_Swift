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
        _ count: Int,
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
    
        for i in 0 ..< count {
            
            let col = Int(i % columns) //所在的列
            let row = Int(i / columns) //所在的行
            let bgView = UIView(frame: CGRect(x: (xSpace + itemSize.width) * CGFloat(col) + xSpace, y: (ySpace + itemSize.height) * CGFloat(row) + ySpace, width: itemSize.width, height: itemSize.height))
            
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: bgView.bounds.width, height: bgView.bounds.height * 0.8))
            let titleLB = UILabel(frame: CGRect(x: 0, y: btn.bounds.height + 2, width: bgView.bounds.width, height: bgView.bounds.height * 0.19))
            titleLB.textAlignment = NSTextAlignment.center
            bgView.addSubview(btn)
            bgView.addSubview(titleLB)
                
            
            if tag { btn.tag = Int(parentView.frame.origin.x + parentView.frame.origin.y) + i}///tag的计算公式
            if target != nil { btn.addTarget(target, action: selector!, for: controlEvents!) }
            if backgroundColor != nil { bgView.backgroundColor = backgroundColor! }
            if imageForNomals != nil { btn.setImage(imageForNomals![i], for: UIControlState()) }
            if imageForHighlighteds != nil { btn.setImage(imageForHighlighteds![i], for: UIControlState.highlighted) }
            if imageForSelecteds != nil { btn.setImage(imageForSelecteds![i], for: UIControlState.selected) }
            if titleFont != nil { titleLB.font = titleFont! }
            if itemTitle != nil { titleLB.text = itemTitle![i] }
            
            parentView.addSubview(bgView)
            
            if autoResizeParentView {
                if i == (count - 1) {
                    parentView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(row + 1) * CGFloat(ySpace + itemSize.height) + ySpace)
                }
            }
        }
    }
}
