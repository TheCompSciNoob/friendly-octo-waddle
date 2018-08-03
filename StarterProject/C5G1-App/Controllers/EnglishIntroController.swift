//
//  EnglishIntroController.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear
import AVFoundation

class EnglishIntroController: UIViewController {
    
    var device: MBLMetaWear? = nil
    var soundManager: SoundManager!
    var parthTimer: Timer!
    var timeElapsed = 0
    
    override func viewDidLoad() {
        loadMapBackground(root: self.view)
        soundManager = SoundManager(fileNames: [], options: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // start device sending updates
        device?.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            self.soundManager?.updateAngularOrientation(degreesYaw: abs(Float(360 - (obj?.y)!)), degreesPitch: Float((obj?.p)!), degreesRoll: Float((obj?.r)!))
        }
        
        //init timers
        parthTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(moveSounds), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // stop updates from device
        device?.sensorFusion?.eulerAngle.stopNotificationsAsync()
        
        // stop timer
        parthTimer.invalidate()
    }
    
    // 0: story (parth)
    // 1: campfire
    // 2: laugh track (lol)
    // where are footsteps
    
    func initPositions() {
        // change volume and positions of the sounds and person
        soundManager.changeVolume(index: 0, vol: 1)
        soundManager.updateListenerPosition(x: 0, y: 0, z: 0)
        
    }
    
    @objc func moveSounds() {
        Degrees += 1
        let x = soundManager.players()[0].x
        let y = soundManager.players()[0].y
        let z = soundManager.players()[0].z
        soundManager.updatePosition(index: 0, position: AVAudio3DPoint(5 * cos(timeElapsed), y: y, z: 5 * sin(timeElapsed)))
        soundManager.updatePosition(index: 1, position: AVAudio3DPoint(5 * cos(timeElapsed), y: y-1.75, z: 5 * sin(timeElapsed)))
    }
}

let date = Date().addingTimeInterval(5)
let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)

