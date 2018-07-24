//
//  DailyStatisticsViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 9.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import Charts

class DailyStatisticsViewController: UIViewController {

    
    @IBOutlet weak var mDailyChart: BarChartView!
    @IBOutlet weak var mPageControl: UIPageControl!
    var mFirebaseDBHelper : FirebaseDBHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            //self.navigationItem.rightBarButtonItem?.title = "Logout"
        }
        mFirebaseDBHelper = FirebaseDBHelper()
        mFirebaseDBHelper?.fb_get_statistics_daily(barChart: mDailyChart, viewController:self)
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
