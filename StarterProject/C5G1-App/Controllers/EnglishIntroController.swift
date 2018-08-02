//
//  EnglishIntroController.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear

class EnglishIntroController: UIViewController {
    
    var device: MBLMetaWear? = nil
    var soundManager: SoundManager!
    var parthTimer: Timer!
    
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
        parthTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(moveSounds), userInfo: nil, repeats: true)
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
        
    }
}
