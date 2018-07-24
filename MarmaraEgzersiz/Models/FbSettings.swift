//
//  FbUser.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 3.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//
import UIKit
import FirebaseDatabase.FIRDataSnapshot


class FbSettings {
    
    //MARK: Properties
    var pid:String?
    var notificationDays: [String:Bool]?
    var notificationTimes: [String:Bool]?
    var key : String?
    
    
    init(pid:String,notificationDays:[String:Bool],notificationTimes:[String:Bool],key:String) {
        self.pid = pid
        self.notificationDays = notificationDays
        self.notificationTimes = notificationTimes
        self.key = key
    }
    
    init?(snapshot: DataSnapshot) {
        print(snapshot.value)
        if let settingsDict = snapshot.value as? [String : Any] {
            for (key , data) in settingsDict {
                
                
                guard let dict = data as? [String : Any],
                    let pid = dict["pid"] as? String,
                    let notificationDays = dict["notificationDay"] as? [String:Bool],
                    let notificationTimes = dict["notificationTime"] as? [String:Bool]
                    
                    else { return nil }
                
                
                self.pid = pid
                self.notificationDays = notificationDays
                self.notificationTimes = notificationTimes
                self.key = key
                
            }
        }
        
        
    }
}
