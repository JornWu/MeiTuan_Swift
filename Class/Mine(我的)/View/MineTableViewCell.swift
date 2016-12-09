//
//  MineTableViewCell.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/14.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {

    @IBOutlet weak var mTitleLable: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func tableViewCellWith(_ modelAArray: [MineTableViewCellModel]!, tableView: UITableView, indexPath: IndexPath, reuseIndentify: String) -> MineTableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentify, for: indexPath) as? MineTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MineTableViewCell", owner: nil, options: nil)?.last as? MineTableViewCell
        }
        
        cell!.mImageView.image = modelAArray[Int(indexPath.row)].mImage
        cell!.mTitleLable.text = modelAArray[Int(indexPath.row)].mTitleText

        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell!
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
