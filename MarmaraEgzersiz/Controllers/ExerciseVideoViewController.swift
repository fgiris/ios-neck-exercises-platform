//
//  ExerciseVideoViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 6.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ExerciseVideoViewController: UIViewController {

    

    var exerciseVideo : String?
    var sampleLink:String = "http://techslides.com/demos/sample-videos/small.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupPlayer(){
        guard let url = URL(string: sampleLink) else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
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
