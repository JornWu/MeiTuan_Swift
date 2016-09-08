//
//  HotelPriceCell.swift
//  MeiTuan_Swift
//
//  Created by JornWu on 16/9/6.
//  Copyright © 2016年 Jorn.Wu(jorn_wza@sina.com). All rights reserved.
//

import UIKit

class HotelPriceCell: UITableViewCell {

    @IBOutlet weak var rushBuyBtn: UIButton!
    @IBOutlet weak var valueLB: UILabel!
    @IBOutlet weak var priceLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        rushBuyBtn.clipsToBounds = true
        rushBuyBtn.layer.cornerRadius = 3
    }

    @IBAction func rushBuyBtnAction(sender: UIButton) {
        print("立即抢购")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
