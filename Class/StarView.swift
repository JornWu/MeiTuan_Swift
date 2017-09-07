//
//  StartView.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/9/5.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

/*
 *******************************************************************************
 *   这是评分的星星个数视图，直接init(...)传入所需的参数就可以生成视图
 *******************************************************************************
 */

import UIKit

class StarView: UIView {
    
    private var rate: CGFloat! //评分
    private var total: Int! //总分
    private var mStarWH: CGFloat! //星星宽高，默认20
    private var mSpace: CGFloat! //间距，默认3
    private var starImageFull: UIImage! //星星图片(填充的)（表示得到分数）
    private var starImageEmpty: UIImage! //星星图片(未填充的)（表示未得到的分数）
    
    convenience init(withRate rate: CGFloat, total: Int, starWH: CGFloat?, space: CGFloat?, starImageFull: UIImage, starImageEmpty: UIImage) {
        
        var wh: CGFloat
        var sp: CGFloat
        
        if starWH == nil{
            wh = 20 //默认 20
        }else {
            wh = starWH!
        }
        
        if space == nil{
            sp = 3 //默认 3
        }else {
            sp = space!
        }
        
        self.init(frame: CGRect(x: 0, y: 0, width: (wh + sp) * CGFloat(total), height: wh + sp * 2))//根据星星大小来确定
        
        
        self.rate = rate
        self.total = total
        self.mStarWH = wh
        self.mSpace = sp
        self.starImageFull = starImageFull
        self.starImageEmpty = starImageEmpty
        
        setupView()
    }
    
    private func setupView() {
        
        ///比例
        let r = mStarWH / starImageFull.size.width ///因为星星的大小是固定的，所以要适配starView的大小
        let imgWH = starImageFull.size.width ///星星大小
        
        ///1 铺好底层
        for index in 0 ..< total {
            
            let c = index % total
            
            let starView = UIImageView(frame: CGRect(x: mSpace + (imgWH + mSpace) * CGFloat(c), y: mSpace, width: imgWH, height: imgWH))///space为间距
            starView.image = starImageEmpty
            starView.contentMode = UIViewContentMode.left
            
            starView.transform = starView.transform.scaledBy(x: r, y: r)///比例缩放
            starView.frame = CGRect(x: mSpace + (mStarWH + mSpace) * CGFloat(c), y: mSpace, width: mStarWH, height: mStarWH)///调整位置
            
            self.addSubview(starView)
        }
        
        ///2.1 计算最后一个星星的宽度
        let w = rate.truncatingRemainder(dividingBy: 1) * mStarWH ///swift 浮点数可以取余
        
        if w != 0 {//w 为0时裁剪图片出错
            ///2.2 处理最后那个星星
            let fImage = UIImage.cutImage(image: starImageFull, withSize: CGSize(width: w, height: mStarWH))
            
            ///3.铺好得分的星星
            let num = rate - (rate.truncatingRemainder(dividingBy: 1)) + 1
            
            for index in 0 ..< Int(num) {
                
                let c = index % total
                
                if index != Int(num - 1) {
                    
                    let starView = UIImageView(frame: CGRect(x: mSpace + (imgWH + mSpace) * CGFloat(c), y: mSpace, width: imgWH, height: imgWH))
                    starView.image = starImageFull
                    starView.contentMode = UIViewContentMode.left
                    
                    starView.transform = starView.transform.scaledBy(x: r, y: r)///比例缩放
                    starView.frame = CGRect(x: mSpace + (mStarWH + mSpace) * CGFloat(c), y: mSpace, width: mStarWH, height: mStarWH)
                    
                    self.addSubview(starView)
                }else {
                    let starView = UIImageView(frame: CGRect(x: mSpace + (imgWH + mSpace) * CGFloat(c), y: mSpace, width: imgWH, height: imgWH))
                    starView.image = fImage
                    starView.contentMode = UIViewContentMode.left
                    
                    starView.transform = starView.transform.scaledBy(x: r, y: r)///比例缩放
                    starView.frame = CGRect(x: mSpace + (mStarWH + mSpace) * CGFloat(c), y: mSpace, width: mStarWH, height: mStarWH)
                    
                    self.addSubview(starView)
                }
            }
        }else {
            ///3.铺好得分的星星
            for index in 0 ..< Int(rate) {
                
                let c = index % total
                    
                let starView = UIImageView(frame: CGRect(x: mSpace + (imgWH + mSpace) * CGFloat(c), y: mSpace, width: imgWH, height: imgWH))
                starView.image = starImageFull
                starView.contentMode = UIViewContentMode.left
                
                starView.transform = starView.transform.scaledBy(x: r, y: r)///比例缩放
                starView.frame = CGRect(x: mSpace + (mStarWH + mSpace) * CGFloat(c), y: mSpace, width: mStarWH, height: mStarWH)
                
                self.addSubview(starView)

            }
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
