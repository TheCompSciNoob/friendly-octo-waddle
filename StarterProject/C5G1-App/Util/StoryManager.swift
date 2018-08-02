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

class StoryManager {
    //all conversations
    private let promptsAndResponses: [PromptAndResponse]
    private let device: MBLMetaWear
    private var prIndex = -1 //which conversation the user is on
    private var soundManager: SoundManager! //reassigned for each conversation
    
    //current conversation
    private var correctAnswerIndex = -1 //where the right answer is
    
    init(promptsAndResponses: [PromptAndResponse], device: MBLMetaWear) {
        self.promptsAndResponses = promptsAndResponses
        self.device = device
    }
    
    func checkAnswer(answerIndex: Int) -> Bool {
        return self.correctAnswerIndex == answerIndex
    }
    
    func next() -> (String, [String]) {
        //insert correct answer into wrong array
        prIndex+=1
        let currentPR = promptsAndResponses[prIndex]
        var answers = currentPR.wrongResponses.flatMap { $0?.text }
        self.correctAnswerIndex = Int(drand48() * Double(currentPR.wrongResponses.count + 1))
        print("correct index: " + String(correctAnswerIndex))
        if let correct = currentPR.correctResponse?.text {
            answers.insert(correct, at: correctAnswerIndex)
        }
        
        //load files into SoundManager
        var fileNames: [String?] = [currentPR.prompt?.audioPath ?? nil]
        for wrongResponse in currentPR.wrongResponses {
            fileNames.append(wrongResponse?.audioPath)
        }
        fileNames.insert(currentPR.correctResponse?.audioPath ?? nil, at: self.correctAnswerIndex + 1)
        print(fileNames)
        self.soundManager = SoundManager(fileNames: fileNames, options: nil)
        if let prompt = currentPR.prompt {
            self.soundManager?.updatePosition(index: 0, position: AVAudio3DPoint(x: prompt.x, y: prompt.y, z: prompt.z))
        }
        if let correct = currentPR.correctResponse {
            self.soundManager.updatePosition(index: self.correctAnswerIndex, position: AVAudio3DPoint(x: correct.x, y: correct.y, z: correct.z))
        }
        for wrongIndex in 0..<currentPR.wrongResponses.count {
            if let wrong = currentPR.wrongResponses[wrongIndex] {
                self.soundManager.updatePosition(index: wrongIndex + (wrongIndex >= self.correctAnswerIndex ? 1 : 0), position: AVAudio3DPoint(x: wrong.x, y: wrong.y, z: wrong.z))
            }
        }
        
        return (currentPR.prompt?.text ?? "No prompt", answers)
    }
    
    func playCurrentPrompt() {
        self.soundManager.play(index: 0)
    }
    
    func playCurrentAnswer(_ index: Int) {
        self.soundManager.play(index: index + 1)
    }
    
    func hasNext() -> Bool {
        return self.prIndex + 1 < promptsAndResponses.count
    }
    
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
    
    /*
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
    mutating func next() -> (PromptAndResponse, Int) {
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
    }*/
}
