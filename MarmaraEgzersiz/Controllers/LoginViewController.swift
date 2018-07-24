//
//  ViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 22.04.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit;
import os.log
import SkyFloatingLabelTextField

class LoginViewController: UIViewController,UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var helloText: UILabel!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    var isComingFromRegister = false
    var isLoggingOut = false
    var firebaseDBHelper : FirebaseDBHelper!
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 5/255, green: 48/255, blue: 86/255, alpha: 1.0)
    
    @IBOutlet weak var changeLanguageButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        if !isLoggingOut{
            //firebaseDBHelper.fb_check_is_logged_in(viewController: self)
        }
        if isLoggedIn(){
            //var programViewController: ProgramController = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.PROGRAM_VIEW_CONTROLLER) as! ProgramController
            if let day_diff = ControllerFunctionsHelper.calculate_days_between_dates(firstDateString: getProgramStartDate(), secondDateString: ControllerFunctionsHelper.get_todays_date()){
                // Make sure to show last survey after 6 weeks passed and check if the user already completed it
                if day_diff > (42) && !checkIfLastSurveyCompleted(){
                    ControllerFunctionsHelper.present_controller(identifier: Identifiers.LAST_SURVEY_VIEW_CONTROLLER, viewController: self)
                    
                }
                else if !checkIfFirstSurveyCompleted(){
                    ControllerFunctionsHelper.present_controller(identifier: Identifiers.PAIN_SURVEY_VIEW_CONTROLLER, viewController: self)
                    
                }
                else{
                    ControllerFunctionsHelper.present_controller(identifier: Identifiers.EXERCISES_VIEW_CONTROLLER, viewController: self)
                }
                
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn(){
            //var programViewController: ProgramController = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.PROGRAM_VIEW_CONTROLLER) as! ProgramController
            if let day_diff = ControllerFunctionsHelper.calculate_days_between_dates(firstDateString: getProgramStartDate(), secondDateString: ControllerFunctionsHelper.get_todays_date()){
                // Make sure to show last survey after 6 weeks passed and check if the user already completed it
                if day_diff > (42) && !checkIfLastSurveyCompleted(){
                    ControllerFunctionsHelper.present_controller(identifier: Identifiers.LAST_SURVEY_VIEW_CONTROLLER, viewController: self)
                
                }
                else if !checkIfFirstSurveyCompleted(){
                    ControllerFunctionsHelper.present_controller(identifier: Identifiers.PAIN_SURVEY_VIEW_CONTROLLER, viewController: self)

                }
                else{
                    ControllerFunctionsHelper.present_controller(identifier: Identifiers.EXERCISES_VIEW_CONTROLLER, viewController: self)
                }
                
            }
            
        }
 
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        emailTextField.delegate = self
        passwordTextField.delegate = self
        firebaseDBHelper = FirebaseDBHelper()
        loginButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        
        loginButton.clipsToBounds = true
        registerButton.clipsToBounds = true
        
        
        emailTextField.tintColor = overcastBlueColor // the color of the blinking cursor
        emailTextField.textColor = darkGreyColor
        emailTextField.lineColor = lightGreyColor
        emailTextField.selectedTitleColor = overcastBlueColor
        emailTextField.selectedLineColor = overcastBlueColor

        
        passwordTextField.tintColor = overcastBlueColor // the color of the blinking cursor
        passwordTextField.textColor = darkGreyColor
        passwordTextField.lineColor = lightGreyColor
        passwordTextField.selectedTitleColor = overcastBlueColor
        passwordTextField.selectedLineColor = overcastBlueColor
        
        if #available(iOS 10.0, *) {
            os_log("viewDidLoad method", log: OSLog.default, type: .debug)
        } else {
            // Fallback on earlier versions
        }

        if isComingFromRegister{
            ControllerFunctionsHelper.show_error(viewController: self, title: "Hesap oluşturuldu", info: "Kullanıcı hesabınız başarı ile oluşturuldu")
            isComingFromRegister = false
        }
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            helloText.text = "WELCOME"
            passwordTextField.placeholder = "Password"
            loginButton.setTitle("Login", for: .normal)
            registerButton.setTitle("Register", for: .normal)
            changeLanguageButton.setTitle("Dili Türkçe Olarak Değiştir", for: .normal)
            
        }
        else{
            changeLanguageButton.setTitle("Change Language to English", for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func unwindToLogin(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RegisterViewController {
            isComingFromRegister = true
            if #available(iOS 10.0, *) {
                os_log("unwindToLogin method", log: OSLog.default, type: .debug)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    @IBAction func attemptLogin(_ sender: UIButton) {
        firebaseDBHelper.fb_attempt_login(email_password: emailTextField.text!+"_"+passwordTextField.text!, viewController: self)
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
    

    @IBAction func changeLanguage(_ sender: UIButton) {
        let preferences = UserDefaults.standard
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            preferences.set(false, forKey: Keys.userFileLanguageEnglishKey)
        }
        else{
            preferences.set(true, forKey: Keys.userFileLanguageEnglishKey)
        }
        if self.presentedViewController == nil {
            ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: self)
        } else{
            self.dismiss(animated: false) { () -> Void in
                ControllerFunctionsHelper.present_controller(identifier: Identifiers.LOGIN_VIEW_CONTROLLER, viewController: self)
            }
        }
    
        preferences.synchronize()
        

    }
}

