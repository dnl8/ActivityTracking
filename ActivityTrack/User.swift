//
//  User.swift
//  ActivityTrack
//
//  Created by Daniel Holzmann on 03.11.16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit

class User: NSObject {
    var Username: String
    var Password: String
    var Gender: Int
    var Height: Double
    var Weight: Double
    var Age: Int
    var SportActivity: Int
    
    
    init(username:String, password:String, gender:Int, height:Double, weight:Double, age:Int, sportActivity:Int) {
        self.Username=username
        self.Password=password
        self.Gender=gender
        self.Height=height
        self.Weight=weight
        self.Age=age
        self.SportActivity=sportActivity
        
    }
}
