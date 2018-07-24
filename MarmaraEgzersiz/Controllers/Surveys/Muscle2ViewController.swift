//
//  Muscle2ViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 4.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class Muscle2ViewController: UIViewController {

    var painLevel : Int? = 0
    var muscle1 : [String : String]?
    var segmentedControls: [UISegmentedControl]?
    var isBeforeTreatment = true
    
    @IBOutlet weak var ayakST: UILabel!
    @IBOutlet weak var dirsekST: UILabel!
    @IBOutlet weak var dizST: UILabel!
    @IBOutlet weak var kalcaST: UILabel!
    @IBOutlet weak var belST: UILabel!
    @IBOutlet weak var sirtST: UILabel!
    @IBOutlet weak var elST: UILabel!
    @IBOutlet weak var omuzST: UILabel!
    @IBOutlet weak var muscle2SurveyTitle: UILabel!
    
    @IBOutlet weak var boyunST: UILabel!
    @IBOutlet weak var muscle2SurveyExpText: UITextView!
    
    @IBOutlet weak var boyunSC: UISegmentedControl!
    @IBOutlet weak var omuzSC: UISegmentedControl!
    @IBOutlet weak var dirsekSC: UISegmentedControl!
    @IBOutlet weak var elSC: UISegmentedControl!
    @IBOutlet weak var sirtSC: UISegmentedControl!
    @IBOutlet weak var belSC: UISegmentedControl!
    @IBOutlet weak var kalcaSC: UISegmentedControl!
    @IBOutlet weak var dizSC: UISegmentedControl!
    @IBOutlet weak var ayakSC: UISegmentedControl!
    
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ControllerFunctionsHelper.isLanguageEnglish(){
            muscle2SurveyTitle.text = "NORDIC MUSCULOSKELETAL QUESTIONNAIRE"
            muscle2SurveyExpText.text = "During the last 12 monts have you been prevented from carrying out normal activities (e.g. job, housework, hobbies) because of this truoble in;"
            boyunST.text = "Neck"
            omuzST.text = "Shoulders"
            dirsekST.text = "Elbows"
            elST.text = "Wrists/Hands"
            sirtST.text = "Upper Back"
            belST.text = "Lower Back"
            kalcaST.text = "Hips/Thighs"
            dizST.text = "Knees"
            ayakST.text = "Ankles/Feet"
            
            boyunSC.setTitle("Yes", forSegmentAt: 0)
            boyunSC.setTitle("No", forSegmentAt: 1)
            
            omuzSC.setTitle("Yes", forSegmentAt: 0)
            omuzSC.setTitle("No", forSegmentAt: 1)
            
            dirsekSC.setTitle("Yes", forSegmentAt: 0)
            dirsekSC.setTitle("No", forSegmentAt: 1)
            
            elSC.setTitle("Yes", forSegmentAt: 0)
            elSC.setTitle("No", forSegmentAt: 1)
            
            sirtSC.setTitle("Yes", forSegmentAt: 0)
            sirtSC.setTitle("No", forSegmentAt: 1)
            
            belSC.setTitle("Yes", forSegmentAt: 0)
            belSC.setTitle("No", forSegmentAt: 1)
            
            kalcaSC.setTitle("Yes", forSegmentAt: 0)
            kalcaSC.setTitle("No", forSegmentAt: 1)
            
            dizSC.setTitle("Yes", forSegmentAt: 0)
            dizSC.setTitle("No", forSegmentAt: 1)
            
            ayakSC.setTitle("Yes", forSegmentAt: 0)
            ayakSC.setTitle("No", forSegmentAt: 1)
            
            continueButton.setTitle("Continue", for: .normal)
        }
        continueButton.layer.cornerRadius = 10
        
        continueButton.clipsToBounds = true
        segmentedControls = [boyunSC, omuzSC, dirsekSC, elSC, sirtSC, belSC, kalcaSC, dizSC, ayakSC]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func continueToMuscle3(_ sender: UIButton) {
        var muscle2SegmentedData = [String : String]()
        var count = 0
        for sc in segmentedControls!{
            if sc.titleForSegment(at: sc.selectedSegmentIndex)=="Evet"
            {
                muscle2SegmentedData[String(count)]="1"
            }
            else{
                muscle2SegmentedData[String(count)]="2"
            }
            count+=1
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Identifiers.MUSCLE3_VIEW_CONTROLLER) as! Muscle3ViewController
        controller.painLevel = painLevel
        controller.muscle1 = muscle1
        controller.muscle2 = muscle2SegmentedData
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
