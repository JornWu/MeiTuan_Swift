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
        
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        titleLB = UILabel(frame: CGRect.zero)
        subTitleLB = UILabel(frame: CGRect.zero)
        button = UIButton(frame: CGRect.zero)
        button.addTarget(self, action: #selector(AroundMerchantAnnotationView.findRoute), for: .touchUpInside)
        bgView = UIView(frame: CGRect.zero)
        
        bgView.addSubview(titleLB)
        bgView.addSubview(subTitleLB)
        bgView.addSubview(button)
        
        bgView.isHidden = true
        
        imageView = UIImageView(frame: CGRect.zero)
        
        self.addSubview(bgView)
        self.addSubview(imageView)
    }
    
    func findRoute() {
        ///让地图视图去执行相关操作
        
        if self.delegate!.responds( to: #selector(AroundMerchantAnnotationViewDelegate.startFindRoute(withDestination:))) {
            self.delegate!.startFindRoute(withDestination: mMerchantAnnotation.coordinate)
        }
    }
    
    func recoverView() {///恢复视图（只有小图标）
        
        self.bgView.isHidden = true
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        switch mMerchantAnnotation!.merchantDataModel.multiType {///这里只列举一种，其他类似
        case "food,":
            imageView.image = UIImage(named: "icon_map_cateid_1")
        default:
            imageView.image = UIImage(named: "icon_map_cateid_2")
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if self.isSelected {///重新布局
            
            self.bounds = CGRect(x: 0, y: 0, width: 200, height: 90)
            
            bgView.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
            bgView.backgroundColor = UIColor.white
            bgView.layer.borderColor = UIColor.gray.cgColor
            bgView.layer.borderWidth = 1
            bgView.layer.cornerRadius = 3
            
            bgView.isHidden = false
            
            button.frame = CGRect(x: bgView.extWidth() - 30, y: 0, width: 30, height: bgView.extHeight())
            button.backgroundColor = THEMECOLOR
            button.setTitle("查看路线", for: UIControlState())
            button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
            button.titleLabel?.numberOfLines = 0
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.layer.cornerRadius = 3
            
            titleLB.frame = CGRect(x: 10, y: 0, width: bgView.extWidth() - 50, height: bgView.extHeight() * 1 / 3)
            titleLB.text = mMerchantAnnotation!.title
            titleLB.font = UIFont.systemFont(ofSize: 13)
            titleLB.textColor = THEMECOLOR
            
            subTitleLB.frame = CGRect(x: 10, y: bgView.extHeight() * 1 / 3, width: bgView.extWidth() - 50, height: bgView.extHeight() * 2 / 3)
            subTitleLB.text = mMerchantAnnotation!.subtitle
            subTitleLB.numberOfLines = 0
            subTitleLB.font = UIFont.systemFont(ofSize: 10)
            subTitleLB.textColor = UIColor.gray

            imageView.frame = CGRect(x: (self.extWidth() - imageView.extWidth()) / 2, y: self.extHeight() - 30, width: 30, height: 30)

        } else {
            recoverView() ///恢复视图
        }
        
        self.centerOffset = CGPoint(x: 0, y: -1 * self.extHeight() / 2)
        self.calloutOffset = CGPoint(x: 0, y: -1 * self.extHeight() / 2)

    }
    
    


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
