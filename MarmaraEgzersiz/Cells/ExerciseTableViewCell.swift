//
//  ExerciseTableViewCell.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 5.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var doneImage: UIImageView!
    @IBOutlet weak var mSetLabelStaticText: UILabel!
    
    @IBOutlet weak var mRepLabelStaticText: UILabel!
    @IBOutlet weak var mExerciseImage: UIImageView!
    @IBOutlet weak var mExerciseName: UILabel!
    @IBOutlet weak var mSetLabel: UILabel!
    @IBOutlet weak var mRepLabel: UILabel!
    @IBOutlet weak var mDurationLabel: UILabel!
    var eid : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //doneImage.isHidden = true
        // Initialization code
        mExerciseName.lineBreakMode = .byWordWrapping
        mExerciseName.numberOfLines = 0
        //mExerciseName.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //doneImage.isHidden = false

        // Configure the view for the selected state
    }

}
