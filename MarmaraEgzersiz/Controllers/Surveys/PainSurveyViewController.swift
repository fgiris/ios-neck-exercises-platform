//
//  PainSurveyViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 4.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class PainSurveyViewController: UIViewController {

    @IBOutlet weak var paindSlider: UISlider!
    var isBeforeTreatment = true
    
    @IBOutlet weak var painSurveyExpText: UITextView!
    @IBOutlet weak var painSurveyTitle: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ControllerFunctionsHelper.isLanguageEnglish(){
            painSurveyTitle.text = "VISUAL ANALOG SCALA"
            painSurveyExpText.text = "Mark your pain intensity on the neck-shoulder girdle on the scale below after using the smartphone for a long time."
            continueButton.setTitle("Continue", for: .normal)
        }
        continueButton.layer.cornerRadius = 10
        
        continueButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueToMuscle1(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Identifiers.MUSCLE1_VIEW_CONTROLLER) as! Muscle1ViewController
        controller.painLevel = Int(paindSlider.value)
        controller.isBeforeTreatment = isBeforeTreatment
        self.present(controller, animated: true, completion: nil)
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
