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
    var stepCountMode: StepCountMode!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    var pedometer : CMPedometer!
    override func viewDidLoad() {
        super.viewDidLoad()
        initMotionManager()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    enum StepCountMode {
        case HandMode,
             TShirtPocketMode,
             PocketMode
    }
    
    func handleStepCount(acceleration: CMAcceleration){
        
    }
    

    
    func initMotionManager(){
        var accelerationDataY = [Double]()
        
        motionManager = CMMotionManager()
        if  motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates()
            motionManager.accelerometerUpdateInterval = 0.5
            motionManager.startAccelerometerUpdates(to: OperationQueue.main){
                (data, error) in
                accelerationDataY.append((data?.acceleration.y)!)
                self.xLabel.text = String(format: "%.2f", (data?.acceleration.x)!)
                self.yLabel.text = String(format: "%.2f", (data?.acceleration.y)!)
                self.zLabel.text = String(format: "%.2f", (data?.acceleration.z)!)
                if accelerationDataY.count == 10 {
                    self.stepCountMode = self.getStepCountMode(accelerationData: accelerationDataY)
                }
                self.handleStepCount(acceleration: (data?.acceleration)!)
            }
        }
    }
    
    func getStepCountMode(accelerationData:[Double]) ->StepCountMode {
        var pocketCount=0
        var tShirtPocketCount=0
    
        for accY in accelerationData {
            if accY > 0.8 {
                pocketCount += 1
            }else if (accY < -0.8) {
               tShirtPocketCount += 1
            }
        }
        
        if pocketCount > 5 {
          return StepCountMode.PocketMode
        }
        if tShirtPocketCount > 5 {
           return StepCountMode.TShirtPocketMode
        }
        
        return StepCountMode.HandMode
        
    }
    
    
  
    
    func handleDeviceMotionUpdate(motion:CMDeviceMotion){
        // print(CGFloat(motion.userAcceleration.x))
        let sum = sqrt(motion.userAcceleration.x * motion.userAcceleration.x + motion.userAcceleration.y * motion.userAcceleration.y + motion.userAcceleration.z * motion.userAcceleration.z)
        print(sum)
    
    }


}

