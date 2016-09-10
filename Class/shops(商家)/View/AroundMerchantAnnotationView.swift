//
//  AroundMerchantAnnotationView.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/9/8.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit
import MapKit

@objc protocol AroundMerchantAnnotationViewDelegate: NSObjectProtocol {
    func startFindRoute(withDestination to: CLLocationCoordinate2D)
}

class AroundMerchantAnnotationView: MKAnnotationView {
    
    var delegate: AroundMerchantAnnotationViewDelegate!
    
    private var titleLB: UILabel!
    private var subTitleLB: UILabel!
    private var button: UIButton!
    private var bgView: UIView!
    private var imageView: UIImageView!
    
    var mMerchantAnnotation: MerchantAnnotation! {
        didSet {
            setNeedsLayout()///重新布局
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
 
        setupView()
    }
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        titleLB = UILabel(frame: CGRectZero)
        subTitleLB = UILabel(frame: CGRectZero)
        button = UIButton(frame: CGRectZero)
        button.addTarget(self, action: #selector(AroundMerchantAnnotationView.findRoute), forControlEvents: .TouchUpInside)
        bgView = UIView(frame: CGRectZero)
        
        bgView.addSubview(titleLB)
        bgView.addSubview(subTitleLB)
        bgView.addSubview(button)
        
        bgView.hidden = true
        
        imageView = UIImageView(frame: CGRectZero)
        
        self.addSubview(bgView)
        self.addSubview(imageView)
    }
    
    func findRoute() {
        ///让地图视图去执行相关操作
        
        if self.delegate!.respondsToSelector( #selector(AroundMerchantAnnotationViewDelegate.startFindRoute(withDestination:))) {
            self.delegate!.startFindRoute(withDestination: mMerchantAnnotation.coordinate)
        }
    }
    
    func recoverView() {///恢复视图（只有小图标）
        
        self.bgView.hidden = true
        imageView.frame = CGRectMake(0, 0, 30, 30)
        self.frame = CGRectMake(0, 0, 30, 30)
        
        switch mMerchantAnnotation!.merchantDataModel.multiType {///这里只列举一种，其他类似
        case "food,":
            imageView.image = UIImage(named: "icon_map_cateid_1")
        default:
            imageView.image = UIImage(named: "icon_map_cateid_2")
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if self.selected {///重新布局
            
            self.bounds = CGRectMake(0, 0, 200, 90)
            
            bgView.frame = CGRectMake(0, 0, 200, 60)
            bgView.backgroundColor = UIColor.whiteColor()
            bgView.layer.borderColor = UIColor.grayColor().CGColor
            bgView.layer.borderWidth = 1
            bgView.layer.cornerRadius = 3
            
            bgView.hidden = false
            
            button.frame = CGRectMake(bgView.extWidth() - 30, 0, 30, bgView.extHeight())
            button.backgroundColor = THEMECOLOR
            button.setTitle("查看路线", forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(11)
            button.titleLabel?.numberOfLines = 0
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.layer.cornerRadius = 3
            
            titleLB.frame = CGRectMake(10, 0, bgView.extWidth() - 50, bgView.extHeight() * 1 / 3)
            titleLB.text = mMerchantAnnotation!.title
            titleLB.font = UIFont.systemFontOfSize(13)
            titleLB.textColor = THEMECOLOR
            
            subTitleLB.frame = CGRectMake(10, bgView.extHeight() * 1 / 3, bgView.extWidth() - 50, bgView.extHeight() * 2 / 3)
            subTitleLB.text = mMerchantAnnotation!.subtitle
            subTitleLB.numberOfLines = 0
            subTitleLB.font = UIFont.systemFontOfSize(10)
            subTitleLB.textColor = UIColor.grayColor()

            imageView.frame = CGRectMake((self.extWidth() - imageView.extWidth()) / 2, self.extHeight() - 30, 30, 30)

        } else {
            recoverView() ///恢复视图
        }
        
        self.centerOffset = CGPointMake(0, -1 * self.extHeight() / 2)
        self.calloutOffset = CGPointMake(0, -1 * self.extHeight() / 2)

    }
    
    


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
