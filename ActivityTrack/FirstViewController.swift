//
//  FirstViewController.swift
//  ActivityTrack
//
//  Created by Daniel Holzmann on 17.10.16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit
import CoreMotion
import KDCircularProgress

class FirstViewController: UIViewController {
    var motionManager: CMMotionManager!
    var stepCountMode: StepCountMode!
    var pedometer : CMPedometer!
    var steps = 0
    var accArrayY = [Double]()
    var accArrayZ = [Double]()
    var accArrayX = [Double]()
    var counter = 0
    var accThreshold:Double = 0
    var decisionLevel = 0
    var oldTime:Double = 0
    var progress: KDCircularProgress!

    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
     //   SampleReader.readDataFromFile(file: "lichtenberg")
        initMotionManager()
        initProgressRing()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
      
    }
    
   public enum StepCountMode {
            case handMode,
             tShirtPocketMode,
             pocketMode
    }
    
    func initProgressRing(){
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.6
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        progress.set(UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
        progress.center = CGPoint(x: view.center.x, y: view.frame.minY + 200)
        view.addSubview(progress)
    }
    
    
    func handleStepCount(_ acceleration: CMAcceleration){
    
        accArrayX.append(acceleration.x)
        accArrayY.append(acceleration.y)
        accArrayZ.append(acceleration.z)
        var diff:Double = 0.0
        
        if counter != 0 {
         
            switch decisionLevel {
            case 0:
                if accArrayX[counter] < accArrayX[counter - 1] && accArrayX[counter] < accThreshold && (accArrayX.max()! - accArrayX.min()!) > 1.0
                {
                    if oldTime == 0.0 {
                        steps += 1
                        oldTime = Date().timeIntervalSince1970
                    }else{
                        diff = Date().timeIntervalSince1970 - oldTime
                        print(diff)
                        if diff > 0.3  {
                            steps += 1
                            self.progress.animate(0 ,toAngle: Double(steps) * 0.05, duration: 0.001, completion: nil)

                            oldTime = Date().timeIntervalSince1970
                        }
                    }
                }
                break;
                
            case 1:
                if accArrayY[counter] < accArrayY[counter - 1] && accArrayY[counter] < accThreshold && (accArrayY.max()! - accArrayY.min()!) > 1.0
                {
                    if oldTime == 0.0 {
                        steps += 1
                        oldTime = Date().timeIntervalSince1970
                    }else{
                        diff = Date().timeIntervalSince1970 - oldTime
                        print(diff)
                        if diff > 0.3  {
                            steps += 1
                            self.progress.animate(0, toAngle: Double(steps) * 0.05, duration: 0.001, completion: nil)
                            oldTime = Date().timeIntervalSince1970
                        }
                    }
                }
                break;
 
            case 2:
                if accArrayZ[counter] < accArrayZ[counter - 1] && accArrayZ[counter] < accThreshold && (accArrayZ.max()! - accArrayZ.min()!) > 1.0
                {
                    
                    if oldTime == 0.0 {
                        steps += 1
                        oldTime = Date().timeIntervalSince1970
                    }else{
                        diff = Date().timeIntervalSince1970 - oldTime
                        print(diff)
                        if diff > 0.3  {
                            steps += 1
                            self.progress.animate(0, toAngle: Double(steps) * 0.05, duration: 0.01, completion: nil)
                            oldTime = Date().timeIntervalSince1970
                        }
                    }
       
                }
                break;
            default:
                break;
            }
            self.stepsLabel.text = String(self.steps)
            
            
        }
        
        
        if counter == 49 {
         let dffX =  accArrayX.max()! - accArrayX.min()!
         let dffY = accArrayY.max()! - accArrayY.min()!
         let dffZ = accArrayZ.max()! - accArrayZ.min()!
            
            if dffX > dffY && dffX > dffZ {
                decisionLevel = 0
                accThreshold = (accArrayX.max()! + accArrayX.min()!) / 2
            }else if dffY > dffX && dffY > dffZ {
                decisionLevel = 1
                 accThreshold = (accArrayY.max()! + accArrayY.min()!) / 2
            }else {
                 accThreshold = (accArrayZ.max()! + accArrayZ.min()!) / 2
                decisionLevel = 2
            }
            counter = 0
            accArrayZ.removeAll()
            accArrayX.removeAll()
            accArrayY.removeAll()
         
       
        }else {
            counter += 1

        }
        
    }
    

    
    func initMotionManager(){
        var accelerationDataY = [Double]()
        
        motionManager = CMMotionManager()
        if  motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates()
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates()
            motionManager.deviceMotionUpdateInterval = 0.02
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!){
                (data,error) in
                accelerationDataY.append((data?.userAcceleration.y)!)
                if accelerationDataY.count % 10 == 0{
                    self.stepCountMode = self.getStepCountMode(accelerationDataY)
                    accelerationDataY.removeAll()
                }
                self.handleStepCount((data?.userAcceleration)!)
            }
        }
    }
    
    func getStepCountMode(_ accelerationData:[Double]) ->StepCountMode {
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
          return StepCountMode.pocketMode
        }
        if tShirtPocketCount > 5 {
           return StepCountMode.tShirtPocketMode
        }
        
        return StepCountMode.handMode
        
    }


}

