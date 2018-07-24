//
//  SettingsTableViewCell.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 8.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hoursSwitch: UISwitch!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var daysSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
