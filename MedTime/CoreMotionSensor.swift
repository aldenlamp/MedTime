//
//  CoreMotionSensor.swift
//  HackNYU
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import CoreMotion

class CoreMotionSensor{
    
    private let motionManager = CMMotionManager()
    
    init() {
        if motionManager.isDeviceMotionAvailable{
            print("What does this do")
        }
        motionManager.deviceMotionUpdateInterval = 0.01
    }
    
    var isTrackingMotion = false {
        willSet {
            if newValue{
                startUpdates()
            }else{
                stopUpdates()
            }
        }
    }
    
    private func startUpdates(){
        if motionManager.isDeviceMotionActive{ return }
        motionManager.startDeviceMotionUpdates(
            to: OperationQueue.current!, withHandler: { [weak self]
                (deviceMotion, error) -> Void in
                
                if(error == nil) {
                    self?.handleDeviceMotionUpdate(deviceMotion: deviceMotion!)
                } else {
                    print(error!.localizedDescription)
                }
        })
    }
    
    private func stopUpdates(){
        if !motionManager.isDeviceMotionActive{ return }
        motionManager.stopDeviceMotionUpdates()
    }
    
    var greatestX = 0.0
    var greatestY = 0.0
    var greatestZ = 0.0
    
    private func handleDeviceMotionUpdate(deviceMotion:CMDeviceMotion) {
        let acceleration = deviceMotion.userAcceleration
        
        if roundCurrent(val: acceleration.y) > greatestY{
            greatestY = roundCurrent(val: acceleration.y)
        }
        
        if roundCurrent(val: acceleration.x) > greatestX{
            greatestX = roundCurrent(val: acceleration.x)
        }
        
        if roundCurrent(val: acceleration.z) > greatestZ{
            greatestZ = roundCurrent(val: acceleration.z)
        }
        
        if greatestZ > 4 || greatestX > 4 || greatestY > 4{
            print("\n")
            greatestY = 0.0
            greatestX = 0.0
            greatestZ = 0.0
            NotificationCenter.default.post(name: Notifications.phoneDidDrop, object: nil)
        }
    }
    
    private func degrees(radians:Double) -> Double {
        return 180 / Double.pi * radians
    }
    
    private func roundCurrent(val: Double) -> Double{
        let y = Double(floor(10*val))/10.0
        return y
    }
    
}
