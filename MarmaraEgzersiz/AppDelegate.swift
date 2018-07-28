//
//  AppDelegate.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 22.04.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var counter = 0
    var timer : Timer?
    var mFirebaseDBHelper : FirebaseDBHelper?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        Database.database().isPersistenceEnabled = true
        mFirebaseDBHelper = FirebaseDBHelper()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        updateVersion()
       
        if isLoggedIn(){
            //var programViewController: ProgramController = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.PROGRAM_VIEW_CONTROLLER) as! ProgramController
            if let day_diff = ControllerFunctionsHelper.calculate_days_between_dates(firstDateString: getProgramStartDate(), secondDateString: ControllerFunctionsHelper.get_todays_date()){
                // Make sure to show last survey after 6 weeks passed and check if the user already completed it
                if day_diff > (42) && !checkIfLastSurveyCompleted(){
                    var presentViewController: LastSurveyViewController = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.LAST_SURVEY_VIEW_CONTROLLER) as! LastSurveyViewController
                    self.window?.rootViewController = presentViewController
                }
                else if !checkIfFirstSurveyCompleted(){
                    var presentViewController: PainSurveyViewController = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.PAIN_SURVEY_VIEW_CONTROLLER) as! PainSurveyViewController
                    self.window?.rootViewController = presentViewController
                }
                else{
                    var presentViewController: ExercisesViewController = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.EXERCISES_VIEW_CONTROLLER) as! ExercisesViewController
                    self.window?.rootViewController = presentViewController
                }
                
            }

        }
        else{
            var loginViewController: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.LOGIN_VIEW_CONTROLLER) as! LoginViewController
            
            self.window?.rootViewController = loginViewController
        }
        
        self.window?.makeKeyAndVisible()
        
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            }
        }
       
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
         print("applicationWillResignActive called")
        mFirebaseDBHelper?.fb_insert_usage_statistic(seconds: counter)
        counter = 0
        timer?.invalidate()
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground called")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground called")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive called")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)


        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate called")
        

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func updateTimer()  {
        counter += 1
        //print(counter)
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {                     completionHandler(.alert)
    }
    
    func isLoggedIn() -> Bool {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: Keys.userFileIsLoggedInKey) == nil {
            return false
        } else {
            return preferences.bool(forKey: Keys.userFileIsLoggedInKey)
        }
    }
    
    func checkIfFirstSurveyCompleted() -> Bool {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: Keys.userFileIsFirstSurveyCompletedKey) == nil {
            return false
        } else {
            return preferences.bool(forKey: Keys.userFileIsFirstSurveyCompletedKey)
        }
    }
    
    func checkIfLastSurveyCompleted() -> Bool {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: Keys.userFileIsLastSurveyCompletedKey) == nil {
            return false
        } else {
            return preferences.bool(forKey: Keys.userFileIsLastSurveyCompletedKey)
        }
    }
    
    func getProgramStartDate() -> String {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: Keys.userFileStartDateKey) == nil {
            return ""
        } else {
            return preferences.string(forKey: Keys.userFileStartDateKey)!
        }
    }
    
    func updateVersion(){
        let preferences = UserDefaults.standard
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {

            print(version)
            if preferences.object(forKey: Keys.userFileLastVersionNumberKey) != nil &&
                Int(version)! > Int((preferences.object(forKey: Keys.userFileLastVersionNumberKey) as! NSString).integerValue){
                preferences.set(version, forKey: Keys.userFileLastVersionNumberKey)
                preferences.set(false, forKey: Keys.userFileIsLoggedInKey)
                preferences.synchronize()
            }
            else{
                preferences.set(version, forKey: Keys.userFileLastVersionNumberKey)
                preferences.synchronize()
            }
        }

        
        
    }

}

