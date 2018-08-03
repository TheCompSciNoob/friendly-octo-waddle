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

    //constants
    private let maxDistance = 10.0
    private let minDistance = 1.0

    //controls Parth's movements
    private var parthTimer: Timer!
    private var parthDistance = 0.0
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
        self.parthTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(moveParth), userInfo: nil, repeats: true)
        self.parthDistance = self.maxDistance
        let zoomDuration = 5.0
        CountDownTimer(secondsInFuture: 99.259, duration: zoomDuration, timeInterval: 0.1) { secondsRemaining in
            self.parthDistance = (self.maxDistance - self.minDistance) * secondsRemaining / zoomDuration + self.minDistance
        }
        CountDownTimer(secondsInFuture: 112.575, duration: zoomDuration, timeInterval: 0.1) { secondsRemaining in
            self.parthDistance = (self.maxDistance - self.minDistance) * (zoomDuration - secondsRemaining) / zoomDuration + self.minDistance
        }
        CountDownTimer(secondsInFuture: 156.0, duration: zoomDuration, timeInterval: 0.1) { secondsRemaining in
            self.parthDistance = (self.maxDistance - self.minDistance) * secondsRemaining / zoomDuration + self.minDistance
        }
        CountDownTimer(secondsInFuture: 168.4, duration: zoomDuration, timeInterval: 0.1) { secondsRemaining in
            self.parthDistance = (self.maxDistance - self.minDistance) * (zoomDuration - secondsRemaining) / zoomDuration + self.minDistance
        }

        soundManager.play(index: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        device?.sensorFusion?.eulerAngle.stopNotificationsAsync()
        for index in 0..<soundManager.fileNames.count {
            soundManager.pause(index: index)
        }

        //stop all timers
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
        soundManager.updatePosition(index: 0, position: AVAudio3DPoint(x: Float(self.parthDistance * cos(degrees * Double.pi / 180.0)), y: y!, z: Float(self.parthDistance * sin(degrees * Double.pi / 180.0))))
        //soundManager.updatePosition(index: 1, position: AVAudio3DPoint(x: Float(5.0 * cos(degrees * Double.pi / 180.0)), y: y! - 1.75, z: Float(5.0 * sin(degrees * Double.pi / 180.0))))
    }
}

class CountDownTimer {
    let secondsInFuture: Double
    let duration: Double
    let timeInterval: Double
    let onUpdate: (Double) -> Void
    private var timer: Timer!
    private var timeElapsed: Double = 0.0

    init(secondsInFuture: Double, duration: Double, timeInterval: Double, onUpdate: @escaping (Double) -> Void) {
        self.secondsInFuture = secondsInFuture
        self.duration = duration
        self.timeInterval = timeInterval
        self.onUpdate = onUpdate
        self.timer = Timer(fireAt: Date().addingTimeInterval(secondsInFuture), interval: self.timeInterval, target: self, selector: #selector(onTick), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }

    func invalidate() {
        timer.invalidate()
    }

    @objc func onTick() {
        self.timeElapsed+=self.timeInterval
        if timeElapsed > duration {
            self.invalidate()
        } else {
            self.onUpdate(duration - timeElapsed)
        }
    }
}