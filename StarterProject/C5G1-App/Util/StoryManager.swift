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
        var fileNames: [String?] = [current.prompt?.audioPath ?? nil, current.correctResponse?.audioPath ?? nil]
        for wrongResponse in current.wrongResponses {
            fileNames.append(wrongResponse?.audioPath)
        }
        print(fileNames)
        self.soundManager = SoundManager(fileNames: fileNames, options: nil)
        if let prompt = current.prompt {
            self.soundManager?.updatePosition(index: 0, position: AVAudio3DPoint(x: prompt.x, y: prompt.y, z: prompt.z))
        }
        if let correct = current.correctResponse {
            self.soundManager?.updatePosition(index: 1, position: AVAudio3DPoint(x: correct.x, y: correct.y, z: correct.z))
        }
        for wrongIndex in 0..<current.wrongResponses.count {
            if let wrong = current.wrongResponses[wrongIndex] {
                self.soundManager?.updatePosition(index: wrongIndex + 2, position: AVAudio3DPoint(x: wrong.x, y: wrong.y, z: wrong.z))
            }
        }
        return current
    }
    
    //checks if there are more conversations
    func hasNext() -> Bool {
        return index + 1 < promptsAndResponses.count
    }
    
    //index 0: prompt
    func playPrompt() -> Bool {
        return soundManager?.play(index: 0) ?? false
    }
    
    //index 1: correct answer
    func playCorrectAnswer() -> Bool {
        return soundManager?.play(index: 1) ?? false
    }
    
    //index >=2: wrong answers
    func playIncorrectAnswer(index: Int) -> Bool{
        return soundManager?.play(index: index + 2) ?? false
    }
}
