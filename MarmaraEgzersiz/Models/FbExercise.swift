//
//  FbUser.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 3.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//
import UIKit
import FirebaseDatabase.FIRDataSnapshot


class FbExercise {
    
    //MARK: Properties
    var eid:String?
    var name: String?
    var exp: String?
    var photo_link: String?
    var rep: Int?
    var rest: Int?
    var set: Int?
    var video_link: String?
    var duration: Int?
    
    init(eid:String,name:String,exp:String,photo_link:String,rep:Int,set:Int,rest:Int,video_link:String,duration:Int) {
        self.eid = eid
        self.name = name
        self.exp = exp
        self.photo_link = photo_link
        self.video_link = video_link
        self.rep = rep
        self.set = set
        self.rest = rest
        self.duration = duration
    }
    
    init?(snapshot: DataSnapshot) {
        if let exerciseDict = snapshot.value as? [String : Any] {
            for (key , data) in exerciseDict {
                
                
                guard let dict = data as? [String : Any],
                    let name = dict["name"] as? String,
                    let exp = dict["exp"] as? String,
                    let photo_link = dict["photo_link"] as? String,
                    let video_link = dict["video_link"] as? String,
                    let rep = dict["rep"] as? Int,
                    let set = dict["set"] as? Int,
                    let rest = dict["rest"] as? Int,
                    let duration = dict["duration"] as? Int
                    else { return nil }
                
                
                self.name = name
                self.exp = exp
                self.photo_link = photo_link
                self.video_link = video_link
                self.rep = rep
                self.set = set
                self.rest = rest
                self.duration = duration
                self.eid = key
                
            }
        }
        
        
    }
}
