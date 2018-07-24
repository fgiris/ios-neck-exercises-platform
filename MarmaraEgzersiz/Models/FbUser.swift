//
//  FbUser.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 3.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//
import UIKit
import FirebaseDatabase.FIRDataSnapshot


class FbUser {
    
        //MARK: Properties
        var uid:String?
        var name: String?
        var email: String?
        var password: String?
        var gender: String?
        var weight: String?
        var height: String?
        var age: String?
        var token: String?
        var email_password:String?
        var programStartDate:String?
        var isLoggedIn:Bool?
        var isFirstSurveyCompleted:Bool?
        var isLastSurveyCompleted:Bool?
    
    init(uid:String,name:String,email:String,password:String,gender:String,height:String,weight:String,age:String,token:String,email_password:String,programStartDate:String,isLoggedIn:Bool,isFirstSurveyCompleted:Bool,isLastSurveyCompleted:Bool) {
            self.uid = uid
            self.name = name
            self.email = email
            self.password = password
            self.age = age
            self.gender = gender
            self.height = height
            self.weight = weight
            self.token = token
            self.email_password = email_password
            self.programStartDate = programStartDate
            self.isLoggedIn = isLoggedIn
            self.isFirstSurveyCompleted = isFirstSurveyCompleted
            self.isLastSurveyCompleted = isLastSurveyCompleted
    }
    
    init?(snapshot: DataSnapshot) {
        if let userDict = snapshot.value as? [String : Any] {
            for (key , data) in userDict {
                
                
                guard let dict = data as? [String : Any],
                    let name = dict["name"] as? String,
                    let email = dict["email"] as? String,
                    let password = dict["password"] as? String,
                    let age = dict["age"] as? String,
                    let gender = dict["gender"] as? String,
                    let height = dict["height"] as? String,
                    let weight = dict["weight"] as? String,
                    let token = dict["token"] as? String,
                    let programStartDate = dict["programStartDate"] as? String,
                    let isLoggedIn = dict["isLoggedIn"] as? Bool,
                    let isFirstSurveyCompleted = dict["isFirstSurveyCompleted"] as? Bool,
                    let isLastSurveyCompleted = dict["lastSurveyCompleted"] as? Bool
                    else { return nil }
                
                
                    self.name = name
                    self.email = email
                    self.password = password
                    self.age = age
                    self.gender = gender
                    self.height = height
                    self.weight = weight
                    self.token = token
                    self.programStartDate = programStartDate
                    self.isLoggedIn = isLoggedIn
                    self.isFirstSurveyCompleted = isFirstSurveyCompleted
                    self.isLastSurveyCompleted = isLastSurveyCompleted
                    self.email_password = email+"_"+password
                    self.uid = key

            }
        }

        
    }
}
