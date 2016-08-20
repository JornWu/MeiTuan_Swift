//
//  HomeTableViewCell.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/12.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var priceLB: UILabel!
    @IBOutlet weak var detailLB: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func creatCellWith(aTableView: UITableView, indexPath: NSIndexPath, reuseIdentifier: String) -> HomeTableViewCell {
        let cell = aTableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        return cell as! HomeTableViewCell
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
