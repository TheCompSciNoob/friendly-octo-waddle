//
//  StoryBuilder.swift
//  iOS
//
//  Created by Cluster 5 on 7/28/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

class StoryBuilder {
    let defaultX: Float
    let defaultY: Float
    let defaultZ: Float
    private var index = -1
    private var storyLine: [PromptAndResponse] = []
    
    init() {
        defaultX = 0.0
        defaultY = 0.0
        defaultZ = 0.0
    }
    
    func createNew() -> StoryBuilder {
        index+=1
        storyLine.append(PromptAndResponse(prompt: nil, correctResponse: nil, wrongResponses: []))
        return self
    }
    
    func p(_ prompt: String, _ audioPath: String, _ x: Float, _ y: Float, _ z: Float) -> StoryBuilder {
        storyLine.append(PromptAndResponse(prompt: AudioInfo(text: prompt, audioPath: audioPath, x: x, y: y, z: z), correctResponse: AudioInfo(text: "", audioPath: "", x: x, y: y, z: z), wrongResponses: []))
        return self
    }
    
    func p(_ prompt: String, _ audioPath: String) -> StoryBuilder {
        return self.p(prompt, audioPath, defaultX, defaultY, defaultZ)
    }
    
    func cr(_ correct: String, _ audioPath: String, _ x: Float, _ y: Float, _ z: Float) -> StoryBuilder {
        storyLine[index].correctResponse = AudioInfo(text: correct, audioPath: audioPath, x: x, y: y, z: z)
        return self
    }
    
    func cr(_ correct: String, _ audioPath: String) -> StoryBuilder {
        return self.cr(correct, audioPath, defaultX, defaultY, defaultZ)
    }
    
    func wr(_ wrong: String, _ audioPath: String, _ x: Float, _ y: Float, _ z: Float) -> StoryBuilder {
        storyLine[index].wrongResponses.append(AudioInfo(text: wrong, audioPath: audioPath, x: x, y: y, z: z))
        return self
    }
    
    func wr(_ wrong: String, _ audioPath: String) -> StoryBuilder {
        return self.wr(wrong, audioPath, defaultX, defaultY, defaultZ)
    }
    
    func build() -> [PromptAndResponse] {
        return storyLine
    }
}
