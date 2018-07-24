//
//  SettingsDaysTableViewCell.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 8.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class SettingsDaysTableViewCell: UITableViewCell {


    @IBOutlet weak var mDaysLabel: UILabel!
    @IBOutlet weak var mDaysSwitch: UISwitch!
    
    var mFirebaseDBHelper : FirebaseDBHelper?
    var id : Int?
    var viewController : SettingsViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mFirebaseDBHelper = FirebaseDBHelper()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func daysSwitchedChecked(_ sender: UISwitch) {
        if !sender.isOn
        {
            mFirebaseDBHelper?.fb_check_and_set_days_settings(daysTableViewCell: self, isSelected: false)
        }
        else{
            mFirebaseDBHelper?.fb_check_and_set_days_settings(daysTableViewCell: self, isSelected: true)
            
        }
    }
}
