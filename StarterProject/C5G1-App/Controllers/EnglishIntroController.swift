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
    private var soundManager: SoundManager!
    private var parthTimer: Timer!
    private var closer1: Timer!
    private var farther1: Timer!
    private var closer2: Timer!
    private var farther2: Timer!
    var degrees: Double = 0.0
    
    override func viewDidLoad() {
        loadMapBackground(root: self.view)
        soundManager = SoundManager(fileNames: ["parthlinescombined.wav"], options: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // start device sending updates
        device?.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            self.soundManager?.updateAngularOrientation(degreesYaw: abs(Float(360 - (obj?.y)!)), degreesPitch: Float((obj?.p)!), degreesRoll: Float((obj?.r)!))
        }
        
        //schedule for future events like Parth moving closer
        parthTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(moveParth), userInfo: nil, repeats: true)
        
        //Timer.scheduledTimer(timeInterval: TimeInterval(99.259), repeats: false)
        //Timer.scheduledTimer(timeInterval: TimeInterval(13.316), repeats: false)
        //Timer.scheduledTimer(timeInterval: TimeInterval(43.425), repeats: false)
        //Timer.scheduledTimer(timeInterval: TimeInterval(12.4), repeats: false)
        
        //test
        soundManager.play(index: 0)
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
    
    @objc func moveParth() {
        degrees += 1
        let y = soundManager.players[0]?.position.y
        soundManager.updatePosition(index: 0, position: AVAudio3DPoint(x: Float(5.0 * cos(degrees * Double.pi / 180.0)), y: y!, z: Float(5.0 * sin(degrees * Double.pi / 180.0))))
        //soundManager.updatePosition(index: 1, position: AVAudio3DPoint(x: Float(5.0 * cos(degrees * Double.pi / 180.0)), y: y! - 1.75, z: Float(5.0 * sin(degrees * Double.pi / 180.0))))
    }
}
