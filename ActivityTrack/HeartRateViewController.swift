//
//  SecondViewController.swift
//  ActivityTrack
//
//  Created by Daniel Holzmann on 17.10.16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit
import CoreBluetooth

class SecondViewController: UIViewController  {

    @IBOutlet weak var heartRateLabel: UILabel!
    
    var heartRate : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

