//
//  FirstViewController.swift
//  ActivityTrack
//
//  Created by Daniel Holzmann on 17.10.16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit
import CoreMotion

class FirstViewController: UIViewController {
    var motionManager: CMMotionManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        initMotionManager()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initMotionManager(){
        motionManager = CMMotionManager()
        motionManager.gyroUpdateInterval = 5
        if motionManager.isDeviceMotionAvailable {
            //do something interesting
        }
        
        motionManager.startDeviceMotionUpdates(
            to: OperationQueue.current!, withHandler: {
                (deviceMotion, error) -> Void in
                
                if(error == nil) {
                    self.handleDeviceMotionUpdate(motion: deviceMotion!)
                } else {
                    //handle the error
                }
        })
        
    }
    
    func handleDeviceMotionUpdate(motion:CMDeviceMotion){
        // print(CGFloat(motion.userAcceleration.x))
        let sum = sqrt(motion.userAcceleration.x * motion.userAcceleration.x + motion.userAcceleration.y * motion.userAcceleration.y + motion.userAcceleration.z * motion.userAcceleration.z)
        print(sum)
    
    }


}

