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
    private let device: MBLMetaWear
    private let soundManager: SoundManager
    private let sector: Double //angle between each consecutive sound
    private var currentAngle = -1.0
    private let defaultDistance = 10.0
    private let closestDistance = 2.0
    
    init(fileNames: [String], device: MBLMetaWear) {
        self.device = device
        self.soundManager = SoundManager(fileNames: fileNames, options: .loops)
        self.sector = 360.0 / Double((soundManager.fileNames.count))
    }
    
    func subscribeToDeviceUpdates() {
        device.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            print((obj?.h)!)
            self.updateAllDistances(newAngle: (obj?.h)!)
        }
    }
    
    func getFocusedSoundIndex(angle: Double) -> Int {
        let sectorSize = 360 / (soundManager.fileNames.count)
        return Int(angle) / sectorSize
    }
    
    //place all sounds at default locations
    func placeSoundsDefault() {
        for index in 0..<(soundManager.fileNames.count) {
            placeSound(index: index, distance: self.defaultDistance)
        }
    }
    
    //place individual sound at one location
    private func placeSound(index: Int, distance: Double) {
        soundManager.updatePosition(index: index, position: AVAudio3DPoint(x: Float(distance * cos(sector * Double(index) * Double.pi / 180)), y: Float(distance * sin(sector * Double(index) * Double.pi / 180)), z: 0.0))
    }
    
    func updateAllDistances(newAngle: Double) {
        currentAngle = newAngle
        let focusedIndex = getFocusedSoundIndex(angle: currentAngle)
        if focusedIndex != getFocusedSoundIndex(angle: newAngle) {
            placeSoundsDefault()
        }
        
        //fades in/out focused sound based on angle
        let offsetAngle = abs(sector * (Double(focusedIndex) + 0.5) - currentAngle)
        let resultDistance = (defaultDistance - closestDistance) * (2 * offsetAngle / sector) + 2.0
        placeSound(index: focusedIndex, distance: resultDistance)
    }
    
    func start() {
        for index in 0..<soundManager.fileNames.count {
            soundManager.play(index: index)
        }
    }
}
