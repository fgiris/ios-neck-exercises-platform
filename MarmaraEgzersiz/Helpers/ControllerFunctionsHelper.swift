//
//  UIFunctionsHelper.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 3.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import UserNotifications
import Charts

class ControllerFunctionsHelper {
    static func show_error(viewController : UIViewController, title: String, info:String) {
        let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        
        viewController.present(alert, animated: true)
    }
    
    static func show_error_eng(viewController : UIViewController, title: String, info:String) {
        let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        viewController.present(alert, animated: true)
    }
    
    static func show_logout(viewController : UIViewController, title: String, info:String) {
        let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Çıkış", style: .default, handler: { action in
            switch action.style{
            case .default:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerStoryBoard")
                viewController.present(controller, animated: true, completion: nil)
                
            case .cancel:
                print("cancel")
            case .destructive:
                print("d")
            }}))
        
        viewController.present(alert, animated: true)
    }
    
    static func show_info(title: String, info:String) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            
            topController.present(alert, animated: true)
        }
        
    }
    
    static func show_info_eng(title: String, info:String) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            topController.present(alert, animated: true)
        }
        
    }
    
    static func show_registered_info(viewController : UIViewController, title: String, info:String) {
        let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style{
            case .default:
                /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerStoryBoard") as? LoginViewController
                controller?.isLoggingOut = true
                viewController.present(controller!, animated: true, completion: nil)*/
                ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: viewController)
            
            case .cancel:
                print("cancel")
            case .destructive:
                print("d")
            }}))
        viewController.present(alert, animated: true)
        
    }
    
    static func get_todays_date() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
        
    }
    
    static func get_date_by_index(index : Int) -> String {
        let date = NSCalendar.current.date(byAdding: .day, value: index, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date!)
        return result
        
    }
    
    static func format_date_from_string(dateString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
      
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        return date
    }
    
    static func calculate_days_between_dates(firstDateString:String,secondDateString:String) -> Int?{
        let calendar = NSCalendar.current
        
        let firstDate = format_date_from_string(dateString: firstDateString)
        let secondDate = format_date_from_string(dateString: secondDateString)

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: secondDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day
    }
    
    static func present_controller(identifier:String,viewController:UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        viewController.present(controller, animated: true, completion: nil)
    }
    
    static func scheduleAppAlarms(hours: Int, minutes: Int, title:String,message:String){
        print("Controller alarm")
        print(message)
        print(title)
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "exerciseNotifications"
        
        content.sound = UNNotificationSound.default()
        
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: message,
                                                                arguments: nil)
        // Configure the trigger for a 7am wakeup.
        var dateInfo = DateComponents()
        dateInfo.hour = hours
        dateInfo.minute = minutes
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: String(hours)+String(minutes), content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print("Alarm Error")
                print(theError.localizedDescription)
            }
        }
                
    }
    
    static func load_bar_graph(mDailyChart:BarChartView, totalDuration: Int, viewController : DailyStatisticsViewController)  {
        var barChartEntry = [ChartDataEntry]()
        barChartEntry.append(BarChartDataEntry(x: 2, y: Double(totalDuration/60)))
        var bar = BarChartDataSet(values: barChartEntry, label: "Egzersiz Süresi (dk)")
        if isLanguageEnglish(){
            bar = BarChartDataSet(values: barChartEntry, label: "Exercise Time (min)")
        }
        bar.setColor(UIColor(red: 5/255.0, green: 48/255.0, blue: 86/255.0, alpha: 1))
        let data = BarChartData()
        data.addDataSet(bar)
        data.barWidth = 0.1
        
        mDailyChart.data = data
        mDailyChart.noDataText = "Egzersiz verisi bulunamadı"
        var desc = Description()
        desc.text = "Günlük Tamamlanan Egzersiz Süresi"
        if isLanguageEnglish(){
             mDailyChart.noDataText = "No exercise data found"
            desc.text = "Daily Finished Exercise Time"
        }
        desc.yOffset = -10
        mDailyChart.chartDescription = desc
        mDailyChart.notifyDataSetChanged()
        mDailyChart.setNeedsDisplay()
        mDailyChart.setNeedsLayout()
        mDailyChart.animate(yAxisDuration: 1)
        
        viewController.view.setNeedsLayout()
        
        //mDailyChart.chartDescription?.text = "Günlük Tamamlanan Egzersiz Süresi"
        
        
        
        
    }
    static func load_line_graph(mWeeklyChart:BarChartView, lineChartEntry: [BarChartDataEntry], viewController : WeeklyStatisticsViewController)  {

        var line = BarChartDataSet(values: lineChartEntry, label: "Egzersiz Süresi (dk)")
        
        if isLanguageEnglish(){
            line = BarChartDataSet(values: lineChartEntry, label: "Exercise Time (min)")
        }
        line.setColor(UIColor(red: 5/255.0, green: 48/255.0, blue: 86/255.0, alpha: 1))
        //line.colors = [UIColor(red: 5/255.0, green: 48/255.0, blue: 86/255.0, alpha: 1)]
        //line.circleColors = [UIColor(red: 5/255.0, green: 48/255.0, blue: 86/255.0, alpha: 1)]
        
       
        let data = BarChartData()
        data.addDataSet(line)

        
        mWeeklyChart.data = data
        mWeeklyChart.noDataText = "Egzersiz verisi bulunamadı"
        var desc = Description()
        desc.text = "Son 1 Haftada Tamamlanan Egzersiz Süreleri"
        if isLanguageEnglish(){
            mWeeklyChart.noDataText = "No exercise data found"
            desc.text = "Finished Exercise Time in Last Week"
        }
        desc.yOffset = -10
        mWeeklyChart.chartDescription = desc
        
        //mDailyChart.chartDescription?.text = "Günlük Tamamlanan Egzersiz Süresi"
        
        
        
        
    }
    
    static func isLanguageEnglish() -> Bool {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: Keys.userFileLanguageEnglishKey) == nil {
            return false
        } else {
            return preferences.bool(forKey: Keys.userFileLanguageEnglishKey)
        }
    }
}
