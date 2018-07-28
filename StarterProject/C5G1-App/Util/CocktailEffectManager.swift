//
//  CocktailEffectManager.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import MetaWear
import AVFoundation

class CocktailEffectManager {
    private var device: MBLMetaWear
    private var soundManager: SoundManager? = nil
    private var currentAngle = -1.0
    
    init(fileNames: [String], device: MBLMetaWear) {
        self.device = device
        self.soundManager = SoundManager(fileNames: fileNames, options: .loops)
    }
    
    func subscribeToDeviceUpdates() {
        device.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            print((obj?.h)!)
            self.updateAllVolumes(newAngle: (obj?.h)!)
        }
    }
    
    func getFocusedSoundIndex(angle: Double) -> Int {
        let sectorSize = 360 / (soundManager?.fileNames.count)!
        return Int(angle) / sectorSize
    }
    
    //place sounds at appropriate location
    func placeSounds() {
        let distance = 5.0
        let sector = 360.0 / Double((soundManager?.fileNames.count)!) //angle between each consecutive sound
        for index in 0..<(soundManager?.fileNames.count)! {
            soundManager?.updatePosition(index: index, position: AVAudio3DPoint(x: Float(distance * cos(sector * Double(index) * Double.pi / 180)), y: Float(distance * sin(sector * Double(index) * Double.pi / 180)), z: 0.0))
        }
    }
    
    func updateAllVolumes(newAngle: Double) {
        if getFocusedSoundIndex(angle: currentAngle) != getFocusedSoundIndex(angle: newAngle) {
            currentAngle = newAngle
            for index in 0..<(soundManager?.fileNames.count)! {
                soundManager?.changeVolume(index: index, vol: 0.1)
            }
            soundManager?.changeVolume(index: getFocusedSoundIndex(angle: currentAngle), vol: 1)
        }
    }
    
    func start() {
        for index in 0..<(soundManager?.fileNames.count)! {
            soundManager?.play(index: index)
        }
    }
}
