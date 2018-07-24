//
//  LastSurveyViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 4.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class LastSurveyViewController: UIViewController {

    @IBOutlet weak var satisfactionSlider: UISlider!
    var firebaseDBHelper : FirebaseDBHelper?
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var lastSurveyExpText: UITextView!
    @IBOutlet weak var lastSurveyTitle: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if ControllerFunctionsHelper.isLanguageEnglish(){
            lastSurveyTitle.text = "Mobile App Satisfaction Assessment"
            lastSurveyExpText.text = "Evaluate your enhanced mobile app experience for long-time smartphone usage."
            continueButton.setTitle("Continue", for: .normal)
            
        }
        continueButton.layer.cornerRadius = 10
        
        continueButton.clipsToBounds = true
        firebaseDBHelper = FirebaseDBHelper()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func continueToPainSurvey(_ sender: UIButton) {
        firebaseDBHelper?.fb_submit_last_survey(viewController: self, satisfactionLevel: Int(satisfactionSlider.value))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
