//
//  FirebaseDBHelper.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 3.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//
import UIKit
import FirebaseDatabase
import FirebaseInstanceID
import os.log
import UserNotifications
import Charts


class FirebaseDBHelper {

    var ref: DatabaseReference!
    var token : String!
    
    init() {
        // Initialize FB DB reference object
        ref = Database.database().reference()
        token = InstanceID.instanceID().token()
        //print("TOKEN: "+token)
    }
    
    
    func fb_register_user(user:[String : Any], viewController : UIViewController) {
        ref.child("users").queryOrdered(byChild: "email").queryEqual(toValue: user["email"]).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0
            {
                if ControllerFunctionsHelper.isLanguageEnglish(){
                    ControllerFunctionsHelper.show_error(viewController: viewController,title:"Registration Error", info: "This email is already registered to the system")
                }
                else{
                    ControllerFunctionsHelper.show_error(viewController: viewController,title:"Kayıt Yapılamadı", info: "Bu emaile kayıtlı kullanıcı zaten bulunmaktadır")
                }
            }
            
            else {
                self.ref.child("users").childByAutoId().setValue(user)
                if ControllerFunctionsHelper.isLanguageEnglish(){
                    ControllerFunctionsHelper.show_error(viewController: viewController,title:"Registration Successful", info: "Your registration is successful")
                }
                else{
                    ControllerFunctionsHelper.show_registered_info(viewController: viewController, title: "Kayıt Yapıldı", info: "Kullanıcı kaydınız başarı ile oluşturuldu")
                }
                ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: viewController)
                

            }
        })

    }
    
    func fb_load_exercises(cell: ExerciseTableViewCell, indexPath : IndexPath, viewController : UITableViewController) {
        print(indexPath.row)
        ref.child("exercises").queryOrdered(byChild: "eid").queryEqual(toValue: indexPath.row+1).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.childrenCount > 0
                {
                    print("Desc snap: "+snapshot.debugDescription)
                    if let exercise = FbExercise(snapshot: snapshot) {
                        cell.mExerciseName.text = exercise.name
                        cell.mExerciseImage.image = UIImage(named: String((indexPath.row+1)))
                        cell.mSetLabel.text = String(exercise.set ?? 1111)
                        //cell.mRepLabel.text = exercise.rep
                        //cell.mDurationLabel.text = exercise.duration
                        //print(exercise.eid)
                    }
                else{
                    os_log("Bulunamadı", type: .error)
                    }
                    
            }
        })
                    
    }
    
    func fb_attempt_login(email_password:String, viewController : UIViewController) {
        if(!NetworkHelper.isConnectedToNetwork()){
            if ControllerFunctionsHelper.isLanguageEnglish(){
                ControllerFunctionsHelper.show_error(viewController: viewController, title: "Network Error", info: "Please check your internet connection and try again")
            }
            else{
                ControllerFunctionsHelper.show_error(viewController: viewController, title: "Bağlantı Hatası", info: "Lütfen internet bağlantınızı kontrol edip tekrar deneyiniz")
            }
            
        }
        else{
            ref.child("users").queryOrdered(byChild: "email_password").queryEqual(toValue: email_password).observeSingleEvent(of: .value, with: { (snapshot) in
                // Check if user exists
                if snapshot.childrenCount > 0
                {
                    if let user = FbUser(snapshot: snapshot) {
                        let preferences = UserDefaults.standard
                        
                        preferences.set(true, forKey: Keys.userFileIsLoggedInKey)
                        preferences.set(user.email, forKey: Keys.userFileEmailKey)
                        preferences.set(user.name, forKey: Keys.userFileNameKey)
                        preferences.set(user.programStartDate, forKey: Keys.userFileStartDateKey)
                        preferences.set(user.isFirstSurveyCompleted, forKey: Keys.userFileIsFirstSurveyCompletedKey)
                        preferences.set(user.isLastSurveyCompleted, forKey: Keys.userFileIsLastSurveyCompletedKey)
                        preferences.synchronize()
                        
                        // Schedule Alarms
                        self.fb_schedule_user_alarms()
                        // Update isLoggedIn state to true
                        self.ref.child("users/"+user.uid!+"/isLoggedIn").setValue(true);
                        if self.token != nil {
                            self.ref.child("users/"+user.uid!+"/token").setValue(self.token);
                        }
                        
                        if let day_diff = ControllerFunctionsHelper.calculate_days_between_dates(firstDateString: user.programStartDate!, secondDateString: ControllerFunctionsHelper.get_todays_date()){
                            // Make sure to show last survey after 6 weeks passed and check if the user already completed it
                            if day_diff > (42) && !user.isLastSurveyCompleted!{
                                ControllerFunctionsHelper.present_controller(identifier: Identifiers.LAST_SURVEY_VIEW_CONTROLLER, viewController: viewController)
                            }
                            else if !user.isFirstSurveyCompleted!{
                                ControllerFunctionsHelper.present_controller(identifier: Identifiers.PAIN_SURVEY_VIEW_CONTROLLER, viewController: viewController)
                            }
                            else{
                                ControllerFunctionsHelper.present_controller(identifier: Identifiers.EXERCISES_VIEW_CONTROLLER, viewController: viewController)
                            }
                            
                        }
                        
                    } else {
                        if ControllerFunctionsHelper.isLanguageEnglish(){
                            ControllerFunctionsHelper.show_error(viewController: viewController, title: "Database Error", info: "Could not retrieve user data")
                        }
                        else{
                            ControllerFunctionsHelper.show_error(viewController: viewController, title: "Veritabanı hatası", info: "Kullanıcı bilgileri alınamadı")
                        }
                    }
                }
                    
                else {
                    if ControllerFunctionsHelper.isLanguageEnglish(){
                        ControllerFunctionsHelper.show_error(viewController: viewController, title: "Missing Info", info: "You entered wrong email or password. Please try again")
                    }
                    else{
                        ControllerFunctionsHelper.show_error(viewController: viewController, title: "Eksik Bilgi", info: "Hatalı email veya şifre girdiniz. Tekrar deneyiniz")
                    }
                    
                }
                
                // handle newly created user here
            })
            
        }
        
    }
    
    func fb_submit_first_survey(viewController : UIViewController, painLevel:Int, muscle1Survey : [String:String], muscle2Survey : [String:String], muscle3Survey : [String:String], isBeforeTreatment: Bool) {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            if snapshot.childrenCount > 0{
                
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("pain_survey").childByAutoId().setValue(["beforeTreatment": isBeforeTreatment,"painLevel":painLevel,"pid":user.uid!])
                    self.ref.child("muscle_survey").childByAutoId().setValue(["beforeTreatment": isBeforeTreatment,"pid":user.uid!,"questionNumber":1,"radioGroupList":muscle1Survey])
                    self.ref.child("muscle_survey").childByAutoId().setValue(["beforeTreatment": isBeforeTreatment,"pid":user.uid!,"questionNumber":2,"radioGroupList":muscle2Survey])
                    self.ref.child("muscle_survey").childByAutoId().setValue(["beforeTreatment": isBeforeTreatment,"pid":user.uid!,"questionNumber":3,"radioGroupList":muscle3Survey])
                    
                    let notificationDay = ["id1":true,"id2":false,"id3":true,"id4":false,"id5":false,"id6":true,"id7":false]
                    let notificationTime = ["id8":false,"id9":false,"id10":true,"id11":false,"id12":false,"id13":false,"id14":true,"id15":false,
                        "id16":false,"id17":false,"id18":false,"id19":true,"id20":false,"id21":false,"id22":false,"id23":false]

                    self.ref.child("settings").childByAutoId().setValue(["notificationDay": notificationDay,"notificationTime":notificationTime,"pid":user.uid!])
                    self.ref.child("users/"+user.uid!+"/isFirstSurveyCompleted").setValue(true);
                    
                    let preferences = UserDefaults.standard
                    if !isBeforeTreatment{
                        preferences.set(true, forKey: Keys.userFileIsLastSurveyCompletedKey)
                    }
                    else{
                        preferences.set(true, forKey: Keys.userFileIsFirstSurveyCompletedKey)
                    }
                    preferences.synchronize()
                    
                    self.fb_schedule_user_alarms()
                    
                    //ControllerFunctionsHelper.present_controller(identifier: Identifiers.SETTINGS_VIEW_CONTROLLER, viewController: viewController)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: Identifiers.EXERCISES_VIEW_CONTROLLER) as? ExercisesViewController
                    controller?.selectedIndex = 2
                    viewController.present(controller!, animated: true, completion: nil)
                }
                
            }
        })
    }
    
    func fb_submit_last_survey(viewController : UIViewController, satisfactionLevel:Int)  {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            if snapshot.childrenCount > 0{
                
                if let user = FbUser(snapshot: snapshot){
                    
                self.ref.child("mobile_app_satisfaction_survey").childByAutoId().setValue(["pid":user.uid!,"satisfactionLevel":satisfactionLevel])
                    
                    self.ref.child("users/"+user.uid!+"/lastSurveyCompleted").setValue(true);
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: Identifiers.PAIN_SURVEY_VIEW_CONTROLLER) as! PainSurveyViewController
                   
                    controller.isBeforeTreatment = false
                    viewController.present(controller, animated: true, completion: nil)
                    
                }
                
            }
        })
    }
    
    func fb_check_is_logged_in(viewController : UIViewController)  {
        let alert = UIAlertController(title: nil, message: "Başlatılıyor...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        viewController.present(alert, animated: true, completion: nil)
        
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            if snapshot.childrenCount > 0{
                
                if let user = FbUser(snapshot: snapshot){
                    
                    if let day_diff = ControllerFunctionsHelper.calculate_days_between_dates(firstDateString: user.programStartDate!, secondDateString: ControllerFunctionsHelper.get_todays_date()){
                        // Make sure to show last survey after 6 weeks passed and check if the user already completed it
                        viewController.dismiss(animated: false, completion: nil)
                        if day_diff > (42) && !user.isLastSurveyCompleted!{
                            ControllerFunctionsHelper.present_controller(identifier: Identifiers.LAST_SURVEY_VIEW_CONTROLLER, viewController: viewController)
                        }
                        else if !user.isFirstSurveyCompleted!{
                            ControllerFunctionsHelper.present_controller(identifier: Identifiers.PAIN_SURVEY_VIEW_CONTROLLER, viewController: viewController)
                        }
                        else{
                            ControllerFunctionsHelper.present_controller(identifier: Identifiers.EXERCISES_VIEW_CONTROLLER, viewController: viewController)
                        }
                    }
                    
                }
                
            }
            
        })
        viewController.dismiss(animated: false, completion: nil)
    }
    
    func fb_insert_exercise_statistic(viewController : UIViewController, duration : Int, exercise : FbExercise) {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            if snapshot.childrenCount > 0{
                
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("finished_exercises").childByAutoId().setValue(["date": ControllerFunctionsHelper.get_todays_date(),"duration":duration,"eid":Int(exercise.eid!), "ex_name":exercise.name, "pid":user.uid, "pid_date":user.uid!+"_"+ControllerFunctionsHelper.get_todays_date()])
                    
                    ControllerFunctionsHelper.present_controller(identifier: Identifiers.EXERCISES_VIEW_CONTROLLER, viewController: viewController)
                    
                }
                
            }
        })
    }
    
    func fb_check_exercise_completed_today(viewController : ExerciseTableViewController){
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            if snapshot.childrenCount > 0{
                
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("finished_exercises").queryOrdered(byChild: "pid_date").queryEqual(toValue: user.uid!+"_"+ControllerFunctionsHelper.get_todays_date()).observeSingleEvent(of: .value, with: { (snapshot) in
                       
                        if snapshot.childrenCount > 0{
                            if let exerciseDict = snapshot.value as? [String : Any] {
                                for (_ , data) in exerciseDict {
                                    
                                    
                                let dict = data as? [String : Any]
                                let eid = dict!["eid"] as? Int
                                    print("Found finished")
                                    print(String(eid!))
                                    let bgColorView = UIView()
                                    bgColorView.backgroundColor = UIColor.red
                                    viewController.tableView.cellForRow(at: IndexPath(row: eid!-1, section: 0))?.setSelected(true, animated: true)
                                    //var cell = viewController.tableView.cellForRow(at: IndexPath(row: eid!-1, section: 0)) as! ExerciseTableViewCell
                                    //guard let cell = viewController.tableView.dequeueReusableCell(withIdentifier: Identifiers.EXERCISE_TABLE_VIEW_CELL, for: IndexPath(row: eid!-1, section: 0)) as? ExerciseTableViewCell  else {
                                        //fatalError("The dequeued cell is not an instance of ExerciseTableViewCell.")
                                    //}
                                    
                                    if let cell = viewController.tableView.cellForRow(at: IndexPath(row: eid!-1, section: 0)) as? ExerciseTableViewCell {
                                        // instead of telling tableView to reload this cell, just configure here
                                        // the changed data, e.g.:
                                        cell.doneImage.isHidden=false
                                    }
                                    //cell.doneImage.isHidden = false
                                    //viewController.tableView.reloadData()
                                    viewController.finishedExercises[eid!-1]=true
                                    
                                }
                            }
                            
                            
                        }
                    })
                    
                    
                    
                }
                
            }
        })
    }
    
    func fb_attempt_loguot(viewController : UIViewController) {
        var message,titleExit,titleCancel,title : String?
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            title = "Logout"
            message = "Do you want to exit from the app?"
            titleExit = "Logout"
            titleCancel = "Cancel"
        }
        else{
            title = "Çıkış"
            message = "Çıkış yapmak istediğinizden emin misiniz?"
            titleExit = "Çıkış"
            titleCancel = "Vazgeç"
        }
        var alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: titleCancel, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: titleExit, style: .default, handler: { action in
            switch action.style{
            case .default:
                let preferences = UserDefaults.standard
                preferences.set(false, forKey: Keys.userFileIsLoggedInKey)
                preferences.synchronize()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerStoryBoard") as? LoginViewController
                controller?.isLoggingOut = true
                viewController.present(controller!, animated: true, completion: nil)
                
                self.ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.childrenCount > 0
                    {
                        if let user = FbUser(snapshot: snapshot) {
                            self.ref.child("users/"+user.uid!+"/isLoggedIn").setValue(false);
                            self.ref.child("users/"+user.uid!+"/token").setValue("");
                            
                            
                        }
                        else{
                            if ControllerFunctionsHelper.isLanguageEnglish(){
                                ControllerFunctionsHelper.show_error(viewController: viewController, title: "Database Error", info: "Could not retrieve user data")
                            }
                            else{
                                ControllerFunctionsHelper.show_error(viewController: viewController, title: "Veritabanı hatası", info: "Kullanıcı bilgileri alınamadı")
                            }
                        }
                        
                    }
                        
                    else {
                        if ControllerFunctionsHelper.isLanguageEnglish(){
                            ControllerFunctionsHelper.show_error(viewController: viewController, title: "Logout Error", info: "Database error. Please check your internet connection and try again")
                        }
                        else{
                             ControllerFunctionsHelper.show_error(viewController: viewController,title:"Çıkış Yapılamadı", info: "Veritabanı hatası. İnternet bağlantınızı kontrol edip tekrar deneyiniz")
                        }
                       
                        
                        
                    }
                })
                
            case .cancel:
                print("cancel")
            case .destructive:
                print("d")
            }}))
        
        viewController.present(alert, animated: true)
        
        
    }
    
    func fb_insert_usage_statistic(seconds : Int)  {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            if snapshot.childrenCount > 0{
                
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("usage_statistics").childByAutoId().setValue(["date": ControllerFunctionsHelper.get_todays_date(), "pid":user.uid, "seconds":seconds])
                    
                    
                }
                
            }
        })
    }
    
    func fb_get_settings(hoursTableView : UITableView, daysTableView : UITableView)  {
        
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            
            if snapshot.childrenCount > 0{
                print("fb_get_settings user found")
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("settings").queryOrdered(byChild: "pid").queryEqual(toValue: user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Check if user exists
                        if snapshot.childrenCount > 0{
                            if let settings = FbSettings(snapshot: snapshot){
                                for (day, value) in settings.notificationDays! {
                                    let idx = day.index(day.startIndex, offsetBy: 2)
                                    let dayId = Int(String(day[idx...]))
                                    var indexPath = IndexPath(row: dayId!-1, section: 0)
                                    guard let daysCell = daysTableView.cellForRow(at: indexPath) as? SettingsDaysTableViewCell
                                        else{
                                            fatalError("Days cell could not catched")
                                    }
                                    daysCell.mDaysSwitch.isOn = value
                                }
                                
                                for (time, value) in settings.notificationTimes! {
                                    let idx = time.index(time.startIndex, offsetBy: 2)
                                    let timeId = Int(String(time[idx...]))
                                    var indexPath = IndexPath(row: timeId!-8, section: 0)
                                    guard let timeCell = hoursTableView.cellForRow(at: indexPath) as? SettingsHoursTableViewCell
                                        else{
                                            fatalError("Days cell could not catched")
                                    }
                                    timeCell.mHoursSwitch.isOn = value
                                }
                                
                                
                            }
                            
                        }
                    })
                    
                    
                }
                
            }
        })
    }
    
    func fb_check_and_set_hours_settings(hoursTableViewCell : SettingsHoursTableViewCell, isSelected : Bool)  {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            
            if snapshot.childrenCount > 0{
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("settings").queryOrdered(byChild: "pid").queryEqual(toValue: user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Check if user exists
                        if snapshot.childrenCount > 0{
                            if let settings = FbSettings(snapshot: snapshot){
                                var counter = 0
                                for (_ , value) in settings.notificationTimes! {
                                    if value{
                                        counter+=1
                                    }
                                    
                                }
                                if !isSelected && counter<4{
                                    ControllerFunctionsHelper.show_error(viewController: hoursTableViewCell.viewController!, title: "Saat Dilimi Az", info: "Lütfen en az 3 saat dilimi seçiniz.")
                                    hoursTableViewCell.mHoursSwitch.isOn = true
                                }
                                else if !isSelected{
                                    self.ref.child("settings/"+settings.key!+"/notificationTime/id"+String(hoursTableViewCell.id!+8)).setValue(false)
                                    self.fb_schedule_user_alarms()
                                }
                                else{
                                    self.ref.child("settings/"+settings.key!+"/notificationTime/id"+String(hoursTableViewCell.id!+8)).setValue(true)
                                    self.fb_schedule_user_alarms()
                                }
                                
                                
                            }
                            
                        }
                    })
                    
                    
                }
                
            }
        })
    }
    
    func fb_check_and_set_days_settings(daysTableViewCell : SettingsDaysTableViewCell, isSelected : Bool)  {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            
            if snapshot.childrenCount > 0{
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("settings").queryOrdered(byChild: "pid").queryEqual(toValue: user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Check if user exists
                        if snapshot.childrenCount > 0{
                            if let settings = FbSettings(snapshot: snapshot){
                                var counter = 0
                                for (_ , value) in settings.notificationDays! {
                                    if value{
                                        counter+=1
                                    }
                                    
                                }
                                if !isSelected && counter<4{
                                    ControllerFunctionsHelper.show_error(viewController: daysTableViewCell.viewController!, title: "Gün Sayısı Az", info: "Lütfen en az 3 gün seçiniz.")
                                    daysTableViewCell.mDaysSwitch.isOn = true
                                }
                                else if !isSelected{
                                    self.ref.child("settings/"+settings.key!+"/notificationDay/id"+String(daysTableViewCell.id!+1)).setValue(false)
                                    self.fb_schedule_user_alarms()
                                }
                                else{
                                    self.ref.child("settings/"+settings.key!+"/notificationDay/id"+String(daysTableViewCell.id!+1)).setValue(true)
                                    self.fb_schedule_user_alarms()

                                }
                                
                                
                            }
                            
                        }
                    })
                    
                    
                }
                
            }
        })
    }
    
    func fb_schedule_user_alarms(){
        var notificationBody : String?
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "It's time to make exercise. How about to start exercises?"
        }
        else{
            notificationBody = "Egzersiz vaktin geldi, egzersiz yapmaya ne dersin?"
        }
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "M.Ü. Neck Exercises", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: notificationBody!,
                                                                arguments: nil)
        content.sound = UNNotificationSound.default()
        
        var dateInfo = DateComponents()
        
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            
            if snapshot.childrenCount > 0{
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("settings").queryOrdered(byChild: "pid").queryEqual(toValue: user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Check if user exists
                        if snapshot.childrenCount > 0{
                            if let settings = FbSettings(snapshot: snapshot){
                                
                                for (day , value) in settings.notificationDays! {
                                    if value{
                                        let idx = day.index(day.startIndex, offsetBy: 2)
                                        let dayId = Int(String(day[idx...]))
                                        dateInfo.weekday=(dayId! + 1)%7
                                        
                                        for (time , value) in settings.notificationTimes! {
                                            if value{
                                                let idx = time.index(time.startIndex, offsetBy: 2)
                                                let timeId = Int(String(time[idx...]))
                                                dateInfo.hour = timeId
                                                dateInfo.minute = 30
                                                
                                                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                                                //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20,repeats: false)
                                                
                                                // Create the request object.
                                                let request = UNNotificationRequest(identifier: day+time, content: content, trigger: trigger)
                                                
                                                
                                                center.add(request) { (error : Error?) in
                                                    if let theError = error {
                                                        print("Alarm Error")
                                                        print(theError.localizedDescription)
                                                    }
                                                }
                                            }
                                            
                                        }

                                    }
                                    
                                }
                                
                            }
                            
                        }
                    })
                    
                    
                }
                
            }
        })
        ///////////////////////////
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "Good morning"
        }
        else{
            notificationBody = "Günaydın"
        }
        ControllerFunctionsHelper.scheduleAppAlarms(hours: 8, minutes: 15, title: "M.Ü. Neck Exercises", message: notificationBody!)
        ///////////////////
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "What do you say to start the day by providing the  smoothness  of the spine?"
        }
        else{
            notificationBody = "Güne omurganın düzgünlüğünü sağlayarak başlamaya ne dersin?"
        }
        ControllerFunctionsHelper.scheduleAppAlarms(hours: 10, minutes: 15, title: "M.Ü. Neck Exercises", message: notificationBody!)
        
        //////////////////
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "Come on feel the stiffness of the spine,  feel the individual vertebrae, stand up as if something is on your head."
        }
        else{
            notificationBody = "Hadi omurganın dikliğini hisset, tek tek omurlarını hisset, başının üzerinde bir şey varmış gibi dik dur."
        }
        ControllerFunctionsHelper.scheduleAppAlarms(hours: 12, minutes: 15, title: "M.Ü. Neck Exercises", message: notificationBody!)
        /////////////////
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "Protect your posture!"
        }
        else{
            notificationBody = "Duruşunu korumalısın!"
        }
        
        ControllerFunctionsHelper.scheduleAppAlarms(hours: 14, minutes: 15, title: "M.Ü. Neck Exercises", message: notificationBody!)
        //////////////////
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "Fix the posture. Feel good!"
        }
        else{
            notificationBody = "Duruşunu düzelt. Kendini iyi hisset!"
        }
        ControllerFunctionsHelper.scheduleAppAlarms(hours: 16, minutes: 15, title: "M.Ü. Neck Exercises", message: notificationBody!)
        //////////////////
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "Fix the posture and reduce the tension in your body!"
        }
        else{
            notificationBody = "Duruşunu düzelt ve vücudundaki gerginlikleri azalt!"
        }
        ControllerFunctionsHelper.scheduleAppAlarms(hours: 18, minutes: 15, title: "M.Ü. Neck Exercises", message: notificationBody!)
        ///////////////////
        if ControllerFunctionsHelper.isLanguageEnglish(){
            notificationBody = "Protect your posture!"
        }
        else{
            notificationBody = "Duruşunu korumalısın!"
        }
        
        ControllerFunctionsHelper.scheduleAppAlarms(hours: 20, minutes: 15, title: "M.Ü. Neck Exercises", message: notificationBody!)
        
        
        
    }
    
    func fb_get_statistics_daily(barChart : BarChartView, viewController : DailyStatisticsViewController)  {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            
            if snapshot.childrenCount > 0{
                if let user = FbUser(snapshot: snapshot){
                    
                    self.ref.child("finished_exercises").queryOrdered(byChild: "pid_date").queryEqual(toValue: user.uid!+"_"+ControllerFunctionsHelper.get_todays_date()).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Check if user exists
                        var totalDuration = 0
                        if snapshot.childrenCount > 0{
                            
                            if let exerciseDict = snapshot.value as? [String : Any] {
                                for (_ , data) in exerciseDict {
                                    
                                    
                                    guard let dict = data as? [String : Any],
                                        let duration = dict["duration"] as? Int
                                        else { return  }
                                    totalDuration+=duration
                                    
                                    
                                }
                            }
                            
                        }
                        ControllerFunctionsHelper.load_bar_graph(mDailyChart: barChart, totalDuration: totalDuration, viewController: viewController)
                        
                    })
                    
                    
                }
                
            }
        })
    }
    
    func fb_get_statistics_weekly(lineChart : LineChartView, viewController : WeeklyStatisticsViewController)  {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            
            if snapshot.childrenCount > 0{
                if let user = FbUser(snapshot: snapshot){
                    var lineChartEntry = [ChartDataEntry]()
                    //lineChartEntry.append(ChartDataEntry(x: Double(2), y: Double(50)))
                    var counter = 7
                    for index in 0...6{
                        
                        self.ref.child("finished_exercises").queryOrdered(byChild: "pid_date").queryEqual(toValue: user.uid!+"_"+ControllerFunctionsHelper.get_date_by_index(index: (-1*index))).observeSingleEvent(of: .value, with: { (snapshot) in
                            // Check if user exists
                            var totalDuration = 0
                            if snapshot.childrenCount > 0{
                                
                                if let exerciseDict = snapshot.value as? [String : Any] {
                                    for (_ , data) in exerciseDict {
                                        
                                        
                                        guard let dict = data as? [String : Any],
                                            let duration = dict["duration"] as? Int
                                            else { return  }
                                        totalDuration+=duration
                                        
                                        
                                    }
                                    print("Total duration:"+String(totalDuration)+"---Date: "+ControllerFunctionsHelper.get_date_by_index(index: -1*index))
                                    lineChartEntry.append(ChartDataEntry(x: Double(index), y: Double(totalDuration/60)))
                                    counter-=1
                                    ControllerFunctionsHelper.load_line_graph(mWeeklyChart: lineChart, lineChartEntry: lineChartEntry, viewController: viewController)
                                }
                                
                                
                            }
                            
                    })
                        
                    }
                    
                    
                    
                }
                
            }
                    })
                    
                    
        
    }
    
    func fb_get_statistics_weekly2(lineChart : LineChartView, viewController : WeeklyStatisticsViewController)  {
        ref.child("users").queryOrdered(byChild: "token").queryEqual(toValue: self.token).observeSingleEvent(of: .value, with: { (snapshot) in
            // Check if user exists
            
            if snapshot.childrenCount > 0{
                if let user = FbUser(snapshot: snapshot){

                        
                        self.ref.child("finished_exercises").queryOrdered(byChild: "pid").queryEqual(toValue: user.uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                            // Check if user exists
                            if snapshot.childrenCount > 0{
                                var durationArr = [0,0,0,0,0,0,0]
                                if let exerciseDict = snapshot.value as? [String : Any] {
                                    for (_ , data) in exerciseDict {
                                        
                                        
                                        guard let dict = data as? [String : Any],
                                            let duration = dict["duration"] as? Int,
                                            let date = dict["date"] as? String
                                            else { return  }
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "dd-MM-yyyy"
                                        guard let dateConverted = dateFormatter.date(from: date) else {
                                            fatalError("ERROR: Date conversion failed due to mismatched format.")
                                        }
                                        guard let dateConvertedToday = dateFormatter.date(from: ControllerFunctionsHelper.get_todays_date()) else {
                                            fatalError("ERROR: Date conversion failed due to mismatched format.")
                                        }

                                        let calendar = NSCalendar.current
                                        
                                        // Replace the hour (time) of both dates with 00:00
                                        let date1 = calendar.startOfDay(for: dateConverted)
                                        let date2 = calendar.startOfDay(for: dateConvertedToday)
                                        
                                        let components = calendar.dateComponents([.day], from: date1, to: date2)
                                        print(components.day!)
                                        if components.day!<7 && components.day!>=0
                                        {
                                            print("Adding Duration")
                                            print(duration)
                                            durationArr[components.day!] += duration
                                        }
                                        
                                        
                                        
                                    }
                                    var lineChartEntry = [ChartDataEntry]()
                                    //lineChartEntry.append(ChartDataEntry(x: 6, y: 200.0))
                                    lineChartEntry.append(ChartDataEntry(x: 1, y: Double(durationArr[6]/60)))
                                    lineChartEntry.append(ChartDataEntry(x: 2, y: Double(durationArr[5]/60)))
                                    lineChartEntry.append(ChartDataEntry(x: 3, y: Double(durationArr[4]/60)))
                                    lineChartEntry.append(ChartDataEntry(x: 4, y: Double(durationArr[3]/60)))
                                    lineChartEntry.append(ChartDataEntry(x: 5, y: Double(durationArr[2]/60)))
                                    lineChartEntry.append(ChartDataEntry(x: 6, y: Double(durationArr[1]/60)))
                                    lineChartEntry.append(ChartDataEntry(x: 7, y: Double(durationArr[0]/60)))
                                    print(Double(durationArr[0]))
                                    //lineChartEntry.append(ChartDataEntry(x: 1, y: 300.0))
                                    //lineChartEntry.append(ChartDataEntry(x: 3, y: Double(durationArr[0])))
                                    //lineChartEntry.append(ChartDataEntry(x: 6, y: 200.0))
                                    //lineChartEntry.append(ChartDataEntry(x: 7, y: 400.0))
                                    
                                    ControllerFunctionsHelper.load_line_graph(mWeeklyChart: lineChart, lineChartEntry: lineChartEntry, viewController: viewController)


                                   
                                }
                                
                                
                            }
                            
                        })
                        
                    }
                    
                    
                    
                }
                
            
        })
        
        
        
    }


}
