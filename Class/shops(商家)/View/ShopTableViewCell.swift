//
//  ShopTableViewCell.swift
//  MeiTuan_Swift
//
//  Created by Jorn Wu on 16/8/26.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var markImageVIew3: UIImageView!
    @IBOutlet weak var markImageView2: UIImageView!
    @IBOutlet weak var markImageView1: UIImageView!
    @IBOutlet weak var dictanceLB: UILabel! //distanceLB
    @IBOutlet weak var priceLB: UILabel!
    @IBOutlet weak var evaluateLB: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var titleBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func creatCellWithTableView(tableView: UITableView, reuseIdentify: String, indexPath: NSIndexPath) -> ShopTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentify, forIndexPath: indexPath) as! ShopTableViewCell
        return cell
    }
    
    
    ///重新根据内容布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titSize = titleBL.text!.boundingRectWithSize(CGSizeMake(200,30), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: evaluateLB.font], context:nil).size
        titleBL.frame = CGRectMake(titleBL.extX(), titleBL.extY(), titSize.width, titSize.height)
        
        ///临时，涉及到是否存在
        markImageView1.frame.origin = CGPointMake(CGRectGetWidth(titleBL.frame), markImageView1.extY())
        markImageView2.frame.origin = CGPointMake(CGRectGetWidth(markImageView1.frame), markImageView1.extY())
        markImageVIew3.frame.origin = CGPointMake(CGRectGetWidth(markImageView2.frame), markImageView1.extY())
        
        let evaSize = evaluateLB.text!.boundingRectWithSize(CGSizeMake(200,30), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: evaluateLB.font], context:nil).size
        evaluateLB.frame = CGRectMake(evaluateLB.extX(), evaluateLB.extY(), evaSize.width, evaSize.height)
        
        let subSize = subTitle.text!.boundingRectWithSize(CGSizeMake(200,30), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: subTitle.font], context:nil).size
        subTitle.frame = CGRectMake(subTitle.extX(), subTitle.extY(), subSize.width, subSize.height)
        
        let priSize = priceLB.text!.boundingRectWithSize(CGSizeMake(200,30), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: priceLB.font], context:nil).size
        subTitle.frame = CGRectMake(SCREENWIDTH - 8 - priceLB.extWidth(), priceLB.extY(), priSize.width, priSize.height)
        
        let dicSize = dictanceLB.text!.boundingRectWithSize(CGSizeMake(200,30), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: dictanceLB.font], context:nil).size
        subTitle.frame = CGRectMake(SCREENWIDTH - 8 - dictanceLB.extWidth(), dictanceLB.extY(), dicSize.width, dicSize.height)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
