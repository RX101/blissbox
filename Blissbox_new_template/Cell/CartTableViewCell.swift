//
//  CartTableViewCell.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 1/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var outLabelGiftboxName: UILabel!
    @IBOutlet weak var outImageViewGiftbox: UIImageView!
    @IBOutlet weak var outLabelGiftboxPackage: UILabel!
    
    @IBOutlet weak var outLabelGiftboxPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
