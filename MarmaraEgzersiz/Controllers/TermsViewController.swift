//
//  TermsViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 7.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var termsOfUsageText: UITextView!
    @IBOutlet weak var acceptButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ControllerFunctionsHelper.isLanguageEnglish(){
            termsOfUsageText.text="About of Neck\n     The neck pain that many people have experienced in recent years is due to the bad posture in daily life. There is no general concept of posture, in different postures, head forward, round shoulders, kyphosis on the back, waist pit may be increased. Head forward posture is a frequent neck stance in the community with long sitting at the desk. Overuse of computers and smartphones, causes head forward posture and neck pain. \nExercise Training Platform\n     M.U. Neck Exercises is an exercise training platform built around preventive and preventive physiotherapy for those who use smartphones for a long time, work at the desk and suffer neck pain for different reasons. This application is especially suitable for use by people with head forward posture.\n     Applications served by being input record is made. Pain and musculoskeletal system problems will be evaluated at the beginning and end of the use of the application. The application is to be used for a minimum of 3 days per week and 6 weeks. After 6 weeks you can renew your program by emailing to pt.mervecan@gmail.com  or you can re-register the application with a different e-mail address. \n     The content of applications, videos copying and / or other personal use rights are protected within the Faculty of Health Sciences at Marmara University.\n     Users are responsible for maintaining the security of their accounts and passwords. If you have any problems with security and usage, you can contact pt.mervecan@gmail.com .\nMerve CAN "
            acceptButton.setTitle( "Continue", for: .normal)
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        acceptButton.layer.cornerRadius = 10
        
        acceptButton.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
