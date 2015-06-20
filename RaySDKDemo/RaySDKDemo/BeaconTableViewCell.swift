//
//  BeaconTableViewCell.swift
//  RaySDKDemo
//
//  Created by Sean Ooi on 6/18/15.
//  Copyright © 2015 Yella Inc. All rights reserved.
//

import UIKit

class BeaconTableViewCell: UITableViewCell {

    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var majorValueLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var minorValueLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var rssiValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
