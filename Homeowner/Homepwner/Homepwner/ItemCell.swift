//
//  ItemCell.swift
//  Homepwner
//
//  Created by Spencer Goff on 6/26/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() { //called on outlets after its loaded from the storyboad; allows font size to change immediately after user changes font settings
        super.awakeFromNib()
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
        
    }
    
}
