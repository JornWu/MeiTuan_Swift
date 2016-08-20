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
    
    class func tableViewCellWith(modelAArray: [MineTableViewCellModel]!, tableView: UITableView, indexPath: NSIndexPath, reuseIndentify: String) -> MineTableViewCell {
        print(indexPath)
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentify, forIndexPath: indexPath) as! MineTableViewCell
        //cell.mImageView.image = modelAArray[Int(indexPath.row)].mImage
        //cell.mTitleLable.text = modelAArray[Int(indexPath.row)].mTitleText
        
        let cell = MineTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIndentify)
        cell.imageView?.image = modelAArray[Int(indexPath.row)].mImage
        cell.textLabel?.text = modelAArray[Int(indexPath.row)].mTitleText
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
