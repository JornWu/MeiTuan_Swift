//
//  AroundMerchantAnnotationView.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/9/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit
import MapKit

class AroundMerchantAnnotationView: MKAnnotationView {
    
    private var titleLB: UILabel
    private var subTitleLB: UILabel
    private var button: UIButton
    
    var mMerchantAnnotation: MerchantAnnotation! {
        didSet {
            setNeedsLayout()///重新布局
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        titleLB = UILabel(frame: CGRectZero)
        subTitleLB = UILabel(frame: CGRectZero)
        button = UIButton(frame: CGRectZero)
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    override init(frame: CGRect) {
        
        titleLB = UILabel(frame: CGRectZero)
        subTitleLB = UILabel(frame: CGRectZero)
        button = UIButton(frame: CGRectZero)
        super.init(frame: frame)
        
        //self.bounds = CGRectMake(0, 0, 200, 60)
        self.bounds = CGRectMake(0, 0, 10, 10)
        self.contentMode = .ScaleAspectFit
//        self.backgroundColor = UIColor.whiteColor()
//        self.layer.borderColor = UIColor.grayColor().CGColor
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = 3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        titleLB = UILabel(frame: CGRectZero)
        subTitleLB = UILabel(frame: CGRectZero)
        button = UIButton(frame: CGRectZero)
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        
//        button.frame = CGRectMake(self.extWidth() - 30, 0, 30, self.extHeight())
//        button.backgroundColor = THEMECOLOR
//        button.setTitle("查看路线", forState: .Normal)
//        button.titleLabel?.font = UIFont.systemFontOfSize(11)
//        button.titleLabel?.numberOfLines = 0
//        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        self.addSubview(button)
//        button.layer.cornerRadius = 3
//        
//        titleLB.frame = CGRectMake(10, 0, self.extWidth() - 50, self.extHeight() * 1 / 3)
//        titleLB.text = mMerchantAnnotation!.title
//        titleLB.font = UIFont.systemFontOfSize(13)
//        titleLB.textColor = THEMECOLOR
//        self.addSubview(titleLB)
//        
//        subTitleLB.frame = CGRectMake(10, self.extHeight() * 1 / 3, self.extWidth() - 50, self.extHeight() * 2 / 3)
//        subTitleLB.text = mMerchantAnnotation!.subtitle
//        subTitleLB.numberOfLines = 0
//        subTitleLB.font = UIFont.systemFontOfSize(10)
//        subTitleLB.textColor = UIColor.grayColor()
//        self.addSubview(subTitleLB)
        
        switch mMerchantAnnotation!.merchantDataModel.multiType {
        case "food,":
            self.image = UIImage(named: "icon_map_cateid_1")
        default:
            self.image = UIImage(named: "icon_map_cateid_2")
        }
        
    }


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
