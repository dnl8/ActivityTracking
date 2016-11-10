//
//  SecondViewController.swift
//  ActivityTrack
//
//  Created by Daniel Holzmann on 17.10.16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit
import CoreBluetooth

class SecondViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    var heartRate:Int = 0
    var centralManager:CBCentralManager!
    var peripheral:CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var heartrateManger = HeartrateManager()
        
      //  self.centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if (central.state == .poweredOn) {
            let serviceUUIDs:[CBUUID] = [CBUUID(string: "0x180D")]
            self.centralManager.scanForPeripherals(withServices: serviceUUIDs, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        peripheral.delegate = self;
        self.peripheral = peripheral;
        self.centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self;
        self.peripheral.discoverServices([CBUUID(string: "0x180D")])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services as [CBService]!{
            peripheral.discoverCharacteristics([CBUUID(string: "0x2A37")], for: service)
        }
        
    }
    
    /*func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: Error!) {
        
        
        for characteristic in service.characteristics as [CBCharacteristic]{
            
    }*/
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! as [CBCharacteristic]{
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var data:NSData = characteristic.value! as NSData
        
        var buffer = [UInt8](repeating: 0x00, count: data.length)
        data.getBytes(&buffer, length: buffer.count)
        
        var bpm:UInt16?
        if (buffer.count >= 2){
            if (buffer[0] & 0x01 == 0){
                bpm = UInt16(buffer[1]);
            }else {
                bpm = UInt16(buffer[1]) << 8
                bpm =  bpm! | UInt16(buffer[2])
            }
        }
        
        if let actualBpm = bpm{
            print(actualBpm)
        }else {
            print(bpm)
        }
        
        
    }
    
    
    
    
    
   


}

