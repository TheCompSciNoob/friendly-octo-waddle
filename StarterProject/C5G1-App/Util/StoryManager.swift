//
//  StoryState.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import MetaWear
import AVFoundation

struct StoryManager {
    var promptsAndResponses: [PromptAndResponse]
    var device: MBLMetaWear
    private var soundManager: SoundManager? = nil
    private var index = -1
    
    init(promptsAndResponses: [PromptAndResponse], device: MBLMetaWear) {
        self.promptsAndResponses = promptsAndResponses
        self.device = device
    }
    
    //constantly listens to device for updates in angular orienatation
    func subscribeToDeviceUpdates() {
        device.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            
            print("h: \(String(describing: obj?.h)), p: \(String(describing: obj?.p)), r: \(String(describing: obj?.r))")
            self.soundManager?.updateAngularOrientation(degreesYaw: abs(Float(360 - (obj?.y)!)), degreesPitch: Float((obj?.p)!), degreesRoll: Float((obj?.r)!))
            }.success { result in
                print("Successfully subscribed")
            }.failure { error in
                print("Error on subscribe: \(error)")
        }
    }
    
    //returns the next conversation
    mutating func next() -> PromptAndResponse {
        index+=1
        let current = promptsAndResponses[index]
        var fileNames = [current.question.audioPath, current.correctResponse.audioPath]
        for wrongResponse in current.wrongResponses {
            fileNames.append(wrongResponse.audioPath)
        }
        self.soundManager = SoundManager(fileNames: fileNames, options: nil)
        self.soundManager?.updatePosition(index: 0, position: AVAudio3DPoint(x: current.question.x, y: current.question.y, z: current.question.z))
        self.soundManager?.updatePosition(index: 1, position: AVAudio3DPoint(x: current.correctResponse.x, y: current.correctResponse.y, z: current.correctResponse.z))
        for wrongIndex in 0..<current.wrongResponses.count {
            self.soundManager?.updatePosition(index: wrongIndex + 2, position: AVAudio3DPoint(x: current.wrongResponses[wrongIndex].x, y: current.wrongResponses[wrongIndex].y, z: current.wrongResponses[wrongIndex].z))
        }
        return current
    }
    
    //checks if there are more conversations
    func hasNext() -> Bool {
        return index + 1 < promptsAndResponses.count
    }
    
    //index 0: question
    func playQuestion() {
        soundManager?.play(index: 0)
    }
    
    //index 1: correct answer
    func playCorrectAnswer() {
        soundManager?.play(index: 1)
    }
    
    //index >=2: wrong answers
    func playIncorrectAnswer(index: Int) {
        soundManager?.play(index: index + 2)
    }
}
