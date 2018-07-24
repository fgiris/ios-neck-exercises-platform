//
//  Muscle3ViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 4.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class Muscle3ViewController: UIViewController {

    var painLevel : Int? = 0
    var segmentedControls: [UISegmentedControl]?
    var muscle1 : [String : String]?
    var muscle2 : [String : String]?
    var firebaseDBHelper : FirebaseDBHelper?
    var isBeforeTreatment = true
    
    @IBOutlet weak var ayakST: UILabel!
    @IBOutlet weak var dizST: UILabel!
    @IBOutlet weak var kalcaST: UILabel!
    @IBOutlet weak var belST: UILabel!
    @IBOutlet weak var sirtST: UILabel!
    @IBOutlet weak var elST: UILabel!
    @IBOutlet weak var dirsekST: UILabel!
    @IBOutlet weak var omuzST: UILabel!
    @IBOutlet weak var boyunST: UILabel!
    @IBOutlet weak var muscle3SurveyExpText: UITextView!
    @IBOutlet weak var muscle3SurveyTitle: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var boyunSC: UISegmentedControl!
    @IBOutlet weak var omuzSC: UISegmentedControl!
    @IBOutlet weak var dirsekSC: UISegmentedControl!
    @IBOutlet weak var elSC: UISegmentedControl!
    @IBOutlet weak var sirtSC: UISegmentedControl!
    @IBOutlet weak var belSC: UISegmentedControl!
    @IBOutlet weak var kalcaSC: UISegmentedControl!
    @IBOutlet weak var dizSC: UISegmentedControl!
    @IBOutlet weak var ayakSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ControllerFunctionsHelper.isLanguageEnglish(){
            muscle3SurveyTitle.text = "NORDIC MUSCULOSKELETAL QUESTIONNAIRE"
            muscle3SurveyExpText.text = "During the last 7 days have you had trouble in;"
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
        firebaseDBHelper = FirebaseDBHelper()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitFirstSurvey(_ sender: UIButton) {
        var muscle3SegmentedData = [String : String]()
        var count = 0
        for sc in segmentedControls!{
            if sc.titleForSegment(at: sc.selectedSegmentIndex)=="Evet"
            {
                muscle3SegmentedData[String(count)]="1"
            }
            else{
                muscle3SegmentedData[String(count)]="2"
            }
            count+=1
        }
        firebaseDBHelper?.fb_submit_first_survey(viewController: self, painLevel: painLevel!, muscle1Survey: muscle1!, muscle2Survey: muscle2!, muscle3Survey: muscle3SegmentedData, isBeforeTreatment:isBeforeTreatment)
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
