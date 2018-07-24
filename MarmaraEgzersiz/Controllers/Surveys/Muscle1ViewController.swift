//
//  Muscle1ViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 4.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class Muscle1ViewController: UIViewController {
    
    // MARK: Properties
    var painLevel : Int? = 0
    var segmentedControls: [UISegmentedControl]?
    var isBeforeTreatment = true

    @IBOutlet weak var ayakStaticText: UILabel!
    @IBOutlet weak var dizStaticText: UILabel!
    @IBOutlet weak var kalcaStaticText: UILabel!
    @IBOutlet weak var belStaticText: UILabel!
    @IBOutlet weak var sirtStatictext: UILabel!
    @IBOutlet weak var elStaticText: UILabel!
    @IBOutlet weak var dirseklerStaticText: UILabel!
    @IBOutlet weak var omuzlarStaticText: UILabel!
    @IBOutlet weak var botunStaticText: UILabel!
    @IBOutlet weak var muscleSurvey1ExpText: UITextView!
    @IBOutlet weak var muscleSurvey1Title: UILabel!
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
            muscleSurvey1Title.text = "NORDIC MUSCULOSKELETAL QUESTIONNAIRE"
            muscleSurvey1ExpText.text = "Have you at any time during the last 12 months had trouble (such as ache, pain, discomfort, numbness) in;"
            botunStaticText.text = "Neck"
            omuzlarStaticText.text = "Shoulders"
            dirseklerStaticText.text = "Elbows"
            elStaticText.text = "Wrists/Hands"
            sirtStatictext.text = "Upper Back"
            belStaticText.text = "Lower Back"
            kalcaStaticText.text = "Hips/Thighs"
            dizStaticText.text = "Knees"
            ayakStaticText.text = "Ankles/Feet"
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
        
        // Do any additional setup after loading the view.
        continueButton.layer.cornerRadius = 10
        
        continueButton.clipsToBounds = true
        print("pain level:"+String(painLevel!))
        segmentedControls = [boyunSC, omuzSC, dirsekSC, elSC, sirtSC, belSC, kalcaSC, dizSC, ayakSC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func continueToMuscle2(_ sender: UIButton) {
        var muscle1SegmentedData = [String : String]()
        var count = 0
        for sc in segmentedControls!{
            if sc.titleForSegment(at: sc.selectedSegmentIndex)=="Evet"
            {
                muscle1SegmentedData[String(count)]="1"
            }
            else{
                muscle1SegmentedData[String(count)]="2"
            }
            count+=1
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Identifiers.MUSCLE2_VIEW_CONTROLLER) as! Muscle2ViewController
        controller.painLevel = painLevel
        controller.muscle1 = muscle1SegmentedData
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
