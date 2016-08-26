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
    @IBOutlet weak var dictanceLB: UILabel!
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
