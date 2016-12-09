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
    
    class func creatCellWithTableView(_ tableView: UITableView, reuseIdentify: String, indexPath: IndexPath) -> ShopTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify, for: indexPath) as? ShopTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("ShopTableViewCell", owner: nil, options: nil)?.last as? ShopTableViewCell
        }
        
        return cell!
    }
    
    
    ///重新根据内容布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titSize = titleBL.text!.boundingRect(with: CGSize(width: 200,height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: evaluateLB.font], context:nil).size
        titleBL.frame = CGRect(x: titleBL.extX(), y: titleBL.extY(), width: titSize.width, height: titSize.height)
        
        ///临时，涉及到是否存在
        markImageView1.frame.origin = CGPoint(x: titleBL.frame.width, y: markImageView1.extY())
        markImageView2.frame.origin = CGPoint(x: markImageView1.frame.width, y: markImageView1.extY())
        markImageVIew3.frame.origin = CGPoint(x: markImageView2.frame.width, y: markImageView1.extY())
        
        let evaSize = evaluateLB.text!.boundingRect(with: CGSize(width: 200,height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: evaluateLB.font], context:nil).size
        evaluateLB.frame = CGRect(x: evaluateLB.extX(), y: evaluateLB.extY(), width: evaSize.width, height: evaSize.height)
        
        let subSize = subTitle.text!.boundingRect(with: CGSize(width: 200,height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: subTitle.font], context:nil).size
        subTitle.frame = CGRect(x: subTitle.extX(), y: subTitle.extY(), width: subSize.width, height: subSize.height)
        
        let priSize = priceLB.text!.boundingRect(with: CGSize(width: 200,height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: priceLB.font], context:nil).size
        subTitle.frame = CGRect(x: SCREENWIDTH - 8 - priceLB.extWidth(), y: priceLB.extY(), width: priSize.width, height: priSize.height)
        
        let dicSize = dictanceLB.text!.boundingRect(with: CGSize(width: 200,height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: dictanceLB.font], context:nil).size
        subTitle.frame = CGRect(x: SCREENWIDTH - 8 - dictanceLB.extWidth(), y: dictanceLB.extY(), width: dicSize.width, height: dicSize.height)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
