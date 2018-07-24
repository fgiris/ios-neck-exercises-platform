//
//  RegisterViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 3.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController,UITextFieldDelegate {

    var fbDbHelper:FirebaseDBHelper!
    var activeTextField = SkyFloatingLabelTextField()
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var ageTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var heightTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var weightTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var registerButton: UIButton!
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 5/255, green: 48/255, blue: 86/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ControllerFunctionsHelper.isLanguageEnglish(){
            nameTextField.placeholder = "Name"
            ageTextField.placeholder = "Age"
            heightTextField.placeholder = "Height (cm)"
            weightTextField.placeholder = "Weight (kg)"
            emailTextField.placeholder = "Email"
            passwordTextField.placeholder = "Password"
            genderSegmentedControl.setTitle("Male", forSegmentAt: 0)
            genderSegmentedControl.setTitle("Female", forSegmentAt: 1)
            registerButton.setTitle("Register", for: .normal)
        }
        fbDbHelper = FirebaseDBHelper()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        ageTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
       
        
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
        
        nameTextField.tintColor = overcastBlueColor // the color of the blinking cursor
        nameTextField.textColor = darkGreyColor
        nameTextField.lineColor = lightGreyColor
        nameTextField.selectedTitleColor = overcastBlueColor
        nameTextField.selectedLineColor = overcastBlueColor
        
        ageTextField.tintColor = overcastBlueColor // the color of the blinking cursor
        ageTextField.textColor = darkGreyColor
        ageTextField.lineColor = lightGreyColor
        ageTextField.selectedTitleColor = overcastBlueColor
        ageTextField.selectedLineColor = overcastBlueColor
        
        heightTextField.tintColor = overcastBlueColor // the color of the blinking cursor
        heightTextField.textColor = darkGreyColor
        heightTextField.lineColor = lightGreyColor
        heightTextField.selectedTitleColor = overcastBlueColor
        heightTextField.selectedLineColor = overcastBlueColor
        
        weightTextField.tintColor = overcastBlueColor // the color of the blinking cursor
        weightTextField.textColor = darkGreyColor
        weightTextField.lineColor = lightGreyColor
        weightTextField.selectedTitleColor = overcastBlueColor
        weightTextField.selectedLineColor = overcastBlueColor
        
        registerButton.layer.cornerRadius = 10
        
        registerButton.clipsToBounds = true
        }
    
    func check_required_fields() -> Bool {
        if  nameTextField.text == "" || ageTextField.text == "" ||
            heightTextField.text == "" || weightTextField.text == "" ||
            emailTextField.text == "" || passwordTextField.text == ""
        {
            return false
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        
        return true
    }

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField as! SkyFloatingLabelTextField
        return true
    }
    // Assign the newly active text field to your activeTextField variable
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activeTextField = textField as! SkyFloatingLabelTextField
    }

    @IBAction func register_user(_ sender: UIButton) {
        if !check_required_fields()
        {
            if ControllerFunctionsHelper.isLanguageEnglish(){
                ControllerFunctionsHelper.show_error(viewController: self,title:"Missing Info",info:"Please fill out all of the fields")
            }
            else{
                ControllerFunctionsHelper.show_error(viewController: self,title:"Eksik Bilgi",info:"Lütfen bütün alanları doldurunuz")
            }
            
        }
        else
        {
            let gender:String!  = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)
            let userAttrs = ["name": nameTextField.text!,"email":emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),"password": passwordTextField.text!,"gender": gender,"height": heightTextField.text!,"weight": weightTextField.text!,"age": ageTextField.text!,"token": "","email_password": emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)+"_"+passwordTextField.text!,"programStartDate": ControllerFunctionsHelper.get_todays_date(),"isLoggedIn": false,"isFirstSurveyCompleted": false,"lastSurveyCompleted": false] as [String : Any]
            fbDbHelper.fb_register_user(user:userAttrs,viewController:self)
            
        }
    }
    
}
