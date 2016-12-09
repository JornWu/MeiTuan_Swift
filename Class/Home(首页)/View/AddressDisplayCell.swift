//
//  AddressDisplayCell.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/8/10.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class AddressDisplayCell: UITableViewCell {

    @IBOutlet weak var currentAddressLB: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func tableViewCell(_ tableView: UITableView, indexPath:IndexPath) -> AddressDisplayCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "addressDisplayCell", for: indexPath) as? AddressDisplayCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("AddressDisplayCell", owner: nil, options: nil)?.last as? AddressDisplayCell
        }
        cell!.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
