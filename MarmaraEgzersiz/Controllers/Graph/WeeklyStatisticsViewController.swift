//
//  WeeklyStatisticsViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 9.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import Charts

class WeeklyStatisticsViewController: UIViewController {


    @IBOutlet weak var mWeeklyChart: BarChartView!
    var mFirebaseDBHelper:FirebaseDBHelper?
    override func viewDidLoad() {
        super.viewDidLoad()
        mFirebaseDBHelper = FirebaseDBHelper()
        mFirebaseDBHelper?.fb_get_statistics_weekly2(lineChart: mWeeklyChart, viewController: self)
        //load_graph()
        
         // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func load_graph()  {
        var lineChartEntry = [ChartDataEntry]()
        lineChartEntry.append(ChartDataEntry(x: 1, y: 2))
        lineChartEntry.append(ChartDataEntry(x: 3, y: 7))
        lineChartEntry.append(ChartDataEntry(x: 4, y: 5))
        lineChartEntry.append(ChartDataEntry(x: 9, y: 2))
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Egzersiz Süresi (dk)")
        line1.colors = [UIColor(red: 5/255.0, green: 48/255.0, blue: 86/255.0, alpha: 1)]
        line1.circleColors = [UIColor(red: 5/255.0, green: 48/255.0, blue: 86/255.0, alpha: 1)]
        
        let data = LineChartData()
        
        data.addDataSet(line1)
        
        mWeeklyChart.data = data
        mWeeklyChart.noDataText = "Egzersiz verisi bulunamadı"
        var desc = Description()
        desc.text = "Haftalık Tamamlanan Egzersiz Süreleri"
        desc.yOffset = -10
        mWeeklyChart.chartDescription = desc
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
