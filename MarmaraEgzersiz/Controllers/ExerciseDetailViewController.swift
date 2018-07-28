//
//  ExerciseDetailViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 6.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ExerciseDetailViewController: UIViewController,UITextViewDelegate {

    var exercise : FbExercise?
    var mFirebaseDBHelper : FirebaseDBHelper?
    var isFinished : Bool = false
    
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var mExerciseStartStopButton: UIButton!
    @IBOutlet weak var mExerciseImage: UIImageView!
    @IBOutlet weak var mExerciseName: UILabel!
    @IBOutlet weak var mExerciseSet: UILabel!
    @IBOutlet weak var mExerciseRep: UILabel!
    @IBOutlet weak var mExerciseCounter: UILabel!
    var colorAccent = UIColor(red: 216/255, green: 27/255, blue: 96/255, alpha: 1)
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var exerciseVideo : String = ""

    @IBOutlet weak var setST: UILabel!
    
    @IBOutlet weak var mExerciseExp: UITextView!
    
    @IBOutlet weak var expST: UILabel!
    @IBOutlet weak var repeatST: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ControllerFunctionsHelper.isLanguageEnglish(){
            ControllerFunctionsHelper.show_error_eng(viewController: self, title: "Reminder", info: "Please do not forget to press start and finish button before starting exercise.")
            mExerciseStartStopButton.setTitle("START", for: .normal)
            setST.text = "Sets"
            repeatST.text = "Repeat"
            expST.text = "Explanation"
        }
        else{
            ControllerFunctionsHelper.show_error(viewController: self, title: "Hatırlatma", info: "Egzersiz yaparken başla ve bitir butonuna basmayı unutmayınız.")
        }
        
        mExerciseStartStopButton.layer.cornerRadius = 0.5 * mExerciseStartStopButton.bounds.size.width
       
        mExerciseStartStopButton.clipsToBounds = true
        mExerciseCounter.textAlignment = .center
        //mExerciseCounter.text = String(counter)+" sn"
        //mExerciseExp.delegate = self
        mFirebaseDBHelper = FirebaseDBHelper()
        
        if let exercise = exercise {
            mExerciseName.text = exercise.name
            mExerciseImage.image = UIImage(named: exercise.eid!)
            mExerciseSet.text = String(exercise.set!)
            mExerciseRep.text = String(exercise.rep!)
            mExerciseExp.text = exercise.exp
            exerciseVideo = exercise.video_link!
        
        }
        if isFinished{
            mExerciseStartStopButton.isHidden = true
            //mExerciseCounter.isHidden = true
            mExerciseCounter.text = "Bugün bu egzersizi tamamladınız"
            if ControllerFunctionsHelper.isLanguageEnglish(){
                mExerciseCounter.text = "Completed today"
            }
            mExerciseCounter.font = mExerciseCounter.font.withSize(12)
            mExerciseCounter.textColor = UIColor.lightGray
            //divider.isHidden = true
            
        }
        //mExerciseExp.text = "deneme"
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startStopTimer(_ sender: UIButton) {
        if isPlaying{
            sender.setTitle("BAŞLA", for: .normal)
            if ControllerFunctionsHelper.isLanguageEnglish(){
                mExerciseStartStopButton.setTitle("START", for: .normal)
            }
            timer.invalidate()
            var str = mExerciseCounter.text as! String
            str.removeLast()
            str.removeLast()
            str.removeLast()
            let duration = Int(Float(str)!)
            mFirebaseDBHelper?.fb_insert_exercise_statistic(viewController: self, duration: duration, exercise: exercise!)
        }
        else{
            sender.setTitle("BİTİR", for: .normal)
            if ControllerFunctionsHelper.isLanguageEnglish(){
               
                mExerciseStartStopButton.setTitle("FINISH", for: .normal)
            }
            sender.backgroundColor = colorAccent
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    
    @objc func updateTimer() {
        counter = counter + 0.1
        mExerciseCounter.text = String(format: "%.1f", counter)+" sn"
    }
   
    @IBAction func playVideo(_ sender: UITapGestureRecognizer) {
        let videoURL = URL(fileURLWithPath: NetworkHelper.getVideoFilePathForExercise(exercise: exercise!))
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*guard let exerciseVideoViewController = segue.destination as? ExerciseVideoViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }*/
        
        
        
        //exerciseVideoViewController.exerciseVideo = exerciseVideo
    }
}
