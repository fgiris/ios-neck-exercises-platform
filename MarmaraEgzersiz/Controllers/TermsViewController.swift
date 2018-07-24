//
//  TermsViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 7.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var acceptButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
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
