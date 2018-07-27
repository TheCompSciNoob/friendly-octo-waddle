//
//  SoundManager.swift
//  iOS
//
//  Created by Cluster 5 on 7/26/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import AVFoundation

struct SoundManager {
    var fileNames: [String]
    private var file = AVAudioFile()
    private var buffer = AVAudioPCMBuffer()
    private let engine = AVAudioEngine()
    private var players: [AVAudioPlayerNode] = []
    private let mixer3d = AVAudioEnvironmentNode()
    
    init(fileNames: [String]) {
        self.fileNames = fileNames
        loadFilesIntoBuffer()
        initEngine()
    }
    
    private func initEngine() {
        if engine.isRunning {
            engine.stop()
        } else {
            do {
                try engine.start()
            } catch {
                print("Cannot start engine.")
            }
            initPositions()
        }
    }
    
    private mutating func loadFilesIntoBuffer() {
        //settings for engine
        engine.attach(mixer3d)
        mixer3d.renderingAlgorithm = .sphericalHead
        engine.connect(mixer3d, to: engine.mainMixerNode, format: mixer3d.outputFormat(forBus: 0))
        
        //settings for individual file
        for fileName in fileNames {
            //get file name and extension
            let res = fileName[...fileName.index(before: fileName.index(of: ".")!)]
            let ext = fileName[fileName.index(after: fileName.index(of: ".")!)...]
            print("\(res), \(ext)")
            
            //creating path and file from file name
            //creating a new buffer for each file
            do {
                let url = Bundle.main.url(forResource: String(res), withExtension: String(ext))!
                file = try AVAudioFile(forReading: url)
                buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length))!
                try file.read(into: buffer)
                print("File loaded, buffer frame length: \(buffer.frameLength)")
            } catch {
                print("File failed to load.")
            }
            //creating node for each sound so all sounds can be individually controlled
            let index = players.count
            players.append(AVAudioPlayerNode())
            engine.attach(players[index])
            engine.connect(players[index], to: mixer3d, format: file.processingFormat)
            players[index].renderingAlgorithm = AVAudio3DMixingRenderingAlgorithm(rawValue: 1)!
            players[index].scheduleBuffer(buffer, completionHandler: nil)
            print("Player at index \(index) ready.")
        }
        print("All players ready.")
    }
    
    func initPositions() {
        mixer3d.listenerPosition.x = 0
        mixer3d.listenerPosition.y = 0
        mixer3d.listenerPosition.z = 0
        for player in players {
            player.position = AVAudio3DPoint(x: 0.0, y: 0.0, z: 0.0)
        }
    }
    
    func play(index: Int) {
        players[index].volume = 1
        players[index].play()
    }
    
    func stopEngine() {
        engine.stop()
    }
    
    func changeVolume(index: Int, vol: Float) {
        players[index].volume = vol
    }
    
    func stop(index: Int) {
        players[index].stop()
        players[index].scheduleBuffer(buffer, completionHandler: nil)
    }
    
    func updaetPosition(index: Int, position: AVAudio3DPoint) {
        players[index].position = position
    }
    
    func updateAngularOrientation( degreesYaw: Float) {
        mixer3d.listenerAngularOrientation.yaw = degreesYaw
    }
    
    func updateListenerPosition(x: Float, y: Float, z: Float) {
        mixer3d.listenerPosition.x = x
        mixer3d.listenerPosition.y = y
        mixer3d.listenerPosition.z = z
    }
}
