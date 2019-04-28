//
//  StoryState.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import MetaWear
import AVFoundation

class StoryManager {
    //all conversations
    private let promptsAndResponses: [PromptAndResponse]
    private let device: MBLMetaWear
    private var prIndex = -1 //which conversation the user is on
    private var conversation: SoundManager! //reassigned for each conversation
    private var ambient: SoundManager!
    
    //current conversation
    private var correctAnswerIndex = -1 //where the right answer is
    
    init(promptsAndResponses: [PromptAndResponse], device: MBLMetaWear) {
        self.promptsAndResponses = promptsAndResponses
        self.device = device
        self.ambient = SoundManager(fileNames: ["ambiencefoodcourt.wav"])
        self.initAmbientSounds()
    }
    
    func initAmbientSounds() {
        for index in 0..<ambient.fileNames.count {
            ambient.changeVolume(index: index, vol: 0.5)
        }
    }
    
    func checkAnswer(answerIndex: Int) -> Bool {
        return self.correctAnswerIndex == answerIndex
    }
    
    func next() -> (String, [String]) {
        //insert correct answer into wrong array
        prIndex+=1
        let currentPR = promptsAndResponses[prIndex]
        var answers = currentPR.wrongResponses.compactMap { $0?.text }
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
        self.conversation = SoundManager(fileNames: fileNames)
        if let prompt = currentPR.prompt {
            self.conversation?.updatePosition(index: 0, position: AVAudio3DPoint(x: prompt.x, y: prompt.y, z: prompt.z))
        }
        if let correct = currentPR.correctResponse {
            self.conversation.updatePosition(index: self.correctAnswerIndex, position: AVAudio3DPoint(x: correct.x, y: correct.y, z: correct.z))
        }
        for wrongIndex in 0..<currentPR.wrongResponses.count {
            if let wrong = currentPR.wrongResponses[wrongIndex] {
                self.conversation.updatePosition(index: wrongIndex + (wrongIndex >= self.correctAnswerIndex ? 1 : 0), position: AVAudio3DPoint(x: wrong.x, y: wrong.y, z: wrong.z))
            }
        }
        
        return (currentPR.prompt?.text ?? "No prompt", answers)
    }
    
    func playCurrentPrompt() {
        self.conversation.play(index: 0)
    }
    
    func playCurrentAnswer(_ index: Int) {
        self.conversation.play(index: index + 1)
    }
    
    func playAmbientSounds() {
        for index in 0..<ambient.fileNames.count {
            ambient.play(index: index, options: .loops)
        }
    }
    
    func pauseAmbientSounds() {
        for index in 0..<ambient.fileNames.count {
            ambient.pause(index: index)
        }
    }
    
    func hasNext() -> Bool {
        return self.prIndex + 1 < promptsAndResponses.count
    }
    
    func subscribeToDeviceUpdates() {
        device.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            
            print("h: \(String(describing: obj?.h)), p: \(String(describing: obj?.p)), r: \(String(describing: obj?.r))")
            self.conversation?.updateAngularOrientation(degreesYaw: abs(Float(360 - (obj?.y)!)), degreesPitch: Float((obj?.p)!), degreesRoll: Float((obj?.r)!))
            }.success { result in
                print("Successfully subscribed")
            }.failure { error in
                print("Error on subscribe: \(error)")
        }
    }
    
    func unscubscribeToDeviceUpdates() {
        device.sensorFusion?.eulerAngle.stopNotificationsAsync()
    }
}
