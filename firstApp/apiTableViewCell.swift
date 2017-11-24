//
//  apiTableViewCell.swift
//  firstApp
//
//  Created by Tatsuki Nakatsuka on 2017/11/23.
//  Copyright © 2017年 Tatsuki Nakatsuka. All rights reserved.
//

import UIKit

class apiTableViewCell: UITableViewCell {

    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var sentence: UILabel!
    
    @IBOutlet weak var shopUrl: UILabel!
    
    @IBOutlet weak var couponUrl: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
