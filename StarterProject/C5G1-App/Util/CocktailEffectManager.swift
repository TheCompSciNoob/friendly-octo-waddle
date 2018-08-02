//
//  CocktailEffectManager.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import MetaWear
import AVFoundation

protocol CocktailDelegate {
    
    func onFocusedIndexUpdated(index: Int)
    
    func onAngleUpdated(newAngle: Double)
}

class CocktailEffectManager {
    private let device: MBLMetaWear
    private let targets: SoundManager
    private let ambient: SoundManager
    var cocktailDelegate: CocktailDelegate? = nil
    private let sector: Double //angle between each consecutive sound
    private var currentAngle = -1.0
    private let defaultDistance = 30.0
    private let closestDistance = 2.0
    
    init(ambient: [String], targets: [String], device: MBLMetaWear) {
        self.device = device
        self.targets = SoundManager(fileNames: targets, options: .loops)
        self.ambient = SoundManager(fileNames: ambient, options: .loops)
        self.sector = 360.0 / Double((targets.count))
        self.placeSoundsDefault()
        self.initAmbientSounds()
    }
    
    func initAmbientSounds() {
        for index in 0..<ambient.fileNames.count {
            ambient.changeVolume(index: index, vol: 0.5)
        }
    }
    
    func subscribeToDeviceUpdates() {
        device.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            self.updateAllDistances(newAngle: 360.0 - (obj?.h)!)
        }
    }
    
    func unsubscribeToDeviceUpdates() {
        device.sensorFusion?.eulerAngle.stopNotificationsAsync()
    }
    
    func getFocusedSoundIndex(angle: Double) -> Int {
        let sectorSize = 360 / (targets.fileNames.count)
        return Int(angle) / sectorSize
    }
    
    //place all sounds at default locations
    func placeSoundsDefault() {
        for index in 0..<(targets.fileNames.count) {
            placeSound(index: index, distance: self.defaultDistance)
        }
    }
    
    //place individual sound at one location
    private func placeSound(index: Int, distance: Double) {
        let angle = sector * (Double(index) + 0.5)
        targets.updatePosition(index: index, position: AVAudio3DPoint(x: Float(distance * cos(angle * Double.pi / 180)), y: Float(distance * sin(angle * Double.pi / 180)), z: 0.0))
    }
    
    func updateAllDistances(newAngle: Double) {
        let oldIndex = getFocusedSoundIndex(angle: currentAngle)
        let newIndex = getFocusedSoundIndex(angle: newAngle)
        self.currentAngle = newAngle
        self.cocktailDelegate?.onAngleUpdated(newAngle: self.currentAngle)
        if oldIndex != newIndex {
            self.cocktailDelegate?.onFocusedIndexUpdated(index: newIndex)
            placeSoundsDefault()
        }
        
        //fades in/out focused sound based on angle
        let offsetAngle = abs(sector * (Double(newIndex) + 0.5) - currentAngle)
        let resultDistance = (defaultDistance - closestDistance) * (2 * offsetAngle / sector) + 2.0
        placeSound(index: newIndex, distance: resultDistance)
    }
    
    func start() {
        for index in 0..<targets.fileNames.count {
            targets.play(index: index)
        }
        
        for index in 0..<ambient.fileNames.count {
            ambient.play(index: index)
        }
    }
    
    func pause() {
        for index in 0..<targets.fileNames.count {
            targets.pause(index: index)
        }
        
        for index in 0..<ambient.fileNames.count {
            ambient.pause(index: index)
        }
    }
}
