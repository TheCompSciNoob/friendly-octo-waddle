//
//  StoryState.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

struct StoryManager {
    var promptsAndResponses: [PromptAndResponse]
    private var soundManager: SoundManager? = nil
    private var index = -1
    
    //returns the next conversation
    mutating func next() -> PromptAndResponse {
        index+=1
        let current = promptsAndResponses[index]
        var fileNames = [current.question.audioPath, current.correctResponse.audioPath]
        for wrongResponse in current.wrongResponses {
            fileNames.append(wrongResponse.audioPath)
        }
        self.soundManager = SoundManager(fileNames: fileNames)
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
