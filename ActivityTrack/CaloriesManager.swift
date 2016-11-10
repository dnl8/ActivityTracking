//
//  CaloriesManager.swift
//  ActivityTrack
//
//  Created by Daniel Holzmann on 03.11.16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit

public class CaloriesManager: NSObject {
    
    private static func predictVO2Max(age:Int,gender:Int,height:Int,weight:Int,activityRating:Int) -> Double{
        let ageVal = 0.133 * Double(age)
        let ageVal2 = 0.005 * Double((age * age))
        let genderVal = 11.403 * Double(gender)
        let activityRatingVal = 1.463 * Double(activityRating)
        let ageValFinal = ageVal - ageVal2
        return ageValFinal + genderVal + activityRatingVal + (9.17 * Double(height)) - (0.254 * Double(weight)) + 34.143
    }
    
    static func predictEnergyExpenditure(gen:Int,weight:Int,age:Int, height:Int, activityRating:Int, heartRate:Int) -> Double {
        let V02Max = predictVO2Max(age: age, gender: gen, height: height, weight: weight, activityRating: activityRating)
        let genderVal =  -59.3954 + Double(gen)
        let secondVal = -36.3781 + 0.271 * Double(age) + 0.394 * Double(weight) + 0.404 * V02Max + 0.634 * Double(heartRate)
        let thirdVal = (0.274 * Double(age) + 0.103 * Double(weight) + 0.380 * Double(V02Max) + 0.450 * Double(heartRate))
        return genderVal * secondVal + (1 - Double(gen)) * thirdVal
       
    }

}
