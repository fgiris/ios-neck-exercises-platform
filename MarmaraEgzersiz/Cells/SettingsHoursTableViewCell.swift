//
//  SettingsHoursTableViewCell.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 8.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class SettingsHoursTableViewCell: UITableViewCell {


    @IBOutlet weak var mHoursLabel: UILabel!
    
    @IBOutlet weak var mHoursSwitch: UISwitch!
    

    var id : Int?
    var mFirebaseDBHelper : FirebaseDBHelper?
    var viewController : SettingsViewController?

    
    override func awakeFromNib() {
        mFirebaseDBHelper = FirebaseDBHelper()
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if !sender.isOn
        {
            mFirebaseDBHelper?.fb_check_and_set_hours_settings(hoursTableViewCell: self, isSelected: false)
        }
        else{
            mFirebaseDBHelper?.fb_check_and_set_hours_settings(hoursTableViewCell: self, isSelected: true)

        }
    }
}
