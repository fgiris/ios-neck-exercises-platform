//
//  SettingsViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 8.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mHoursTableView: UITableView!
    @IBOutlet weak var mDaysTableView: UITableView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var languageHeader: UILabel!
    @IBOutlet weak var isEnglishSwitch: UISwitch!
    
    var mFirebaseDBHelper : FirebaseDBHelper?
    
    let hoursData = ["08.00-09.00","09.00-10.00","10.00-11.00","11.00-12.00","12.00-13.00","13.00-14.00","14.00-15.00","15.00-16.00",
                     "16.00-17.00","17.00-18.00","18.00-19.00","19.00-20.00","20.00-21.00","21.00-22.00","22.00-23.00","23.00-00.00"]
    
    let daysData = ["Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi","Pazar"]
    
    let daysDataEnglish = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    
    
    @IBOutlet weak var dayNotificationText: UITextView!
    
    @IBOutlet weak var hourNotificationText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 10

        saveButton.clipsToBounds = true
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            self.navigationItem.title = "Settings"
            self.navigationItem.rightBarButtonItem?.title = "Logout"
            isEnglishSwitch.isOn = true
            languageHeader.text = "Language"
            dayNotificationText.text = "Choose the appropriate time zone in which you would like to receive notifications to exercise during the day.\n\nThe time zone you want to receive notifications(You must select at least 3 different time zones)"
            hourNotificationText.text = "Days you want to receive notifications (You must choose at least 3 days)"
        }
        
        mFirebaseDBHelper = FirebaseDBHelper()
        
        mHoursTableView.dataSource = self
        mHoursTableView.delegate = self
        
        mDaysTableView.dataSource = self
        mDaysTableView.delegate = self
        
        mFirebaseDBHelper?.fb_get_settings(hoursTableView: mHoursTableView, daysTableView: mDaysTableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.mHoursTableView {
            count = hoursData.count
        }
        
        if tableView == self.mDaysTableView {
            count =  daysData.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellHour : SettingsHoursTableViewCell?
        var cellDay : SettingsDaysTableViewCell?
        
        if tableView == self.mHoursTableView {
            guard let cellHours = tableView.dequeueReusableCell(withIdentifier: Identifiers.SETTINGS_HOURS_TABLE_VIEW_CELL, for: indexPath) as? SettingsHoursTableViewCell else{
                fatalError("cell hours could not be initialized")
            }
            
            let previewDetail = hoursData[indexPath.row]
            cellHours.mHoursLabel.text = previewDetail
            cellHours.id = indexPath.row
            cellHours.viewController = self
            return cellHours
            
        }
        
        if tableView == self.mDaysTableView {
            guard let cellDays = tableView.dequeueReusableCell(withIdentifier: Identifiers.SETTINGS_DAYS_TABLE_VIEW_CELL, for: indexPath) as? SettingsDaysTableViewCell else {
                fatalError("cell days could not initialized")
            }
            var previewDetail : String?
            if ControllerFunctionsHelper.isLanguageEnglish(){
                previewDetail = daysDataEnglish[indexPath.row]
            }
            else{
                previewDetail = daysData[indexPath.row]
            }
            
            cellDays.mDaysLabel?.text = previewDetail
            cellDays.id = indexPath.row
            cellDays.viewController = self
            //cellDays.textLabel?.text = previewDetail
            return cellDays
        }
        
        
        return cellDay!
        
    }
    @IBAction func saveSettings(_ sender: UIButton) {
        if ControllerFunctionsHelper.isLanguageEnglish(){
            ControllerFunctionsHelper.show_info(title: "Settings Saved", info: "Settings successfuly updated. You can continue your exercises.")
        }
        else{
            ControllerFunctionsHelper.show_info(title: "Ayarlar Kaydedildi", info: "Ayarlarınız başarı ile kaydedildi. Egzersizlerinize devam edebilirsiniz.")
        }
        
    }
    
    @IBAction func changeLanguage(_ sender: UISwitch) {
        let preferences = UserDefaults.standard
        if sender.isOn
        {
            preferences.set(true, forKey: Keys.userFileLanguageEnglishKey)
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                let alert = UIAlertController(title: "Dil Değişikliği", message: "Dil ayarlarının uygulanması için uygulama baştan başlatılacaktır", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Vazgeç", style: .default, handler: {action in
                    sender.setOn(false, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        if self.presentedViewController == nil {
                            ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: self)
                        } else{
                            self.dismiss(animated: false) { () -> Void in
                                ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: self)
                            }
                        }
                        
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("d")
                    }}))
                
                topController.present(alert, animated: true)
            }
            
        }
        else{
            preferences.set(false, forKey: Keys.userFileLanguageEnglishKey)
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                let alert = UIAlertController(title: "Change Language", message: "The app will be restarted in order to apply changes", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {action in
                    sender.setOn(true, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        if self.presentedViewController == nil {
                            ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: self)
                        } else{
                            self.dismiss(animated: false) { () -> Void in
                                ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: self)
                            }
                        }
                        
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("d")
                    }}))
                
                topController.present(alert, animated: true)
            }
            
            
        }
        preferences.synchronize()
        

        
        
    }
    @IBAction func attemptLogout(_ sender: UIBarButtonItem) {
        mFirebaseDBHelper?.fb_attempt_loguot(viewController: self)
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
