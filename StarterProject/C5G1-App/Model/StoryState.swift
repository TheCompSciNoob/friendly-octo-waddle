//
//  StoryState.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

struct StoryState {
    var promptsAndResponses: [PromptAndResponse]
    private let soundController: SoundController? = nil
    private var index = -1
    
    mutating func next() -> PromptAndResponse {
        index+=1
        return promptsAndResponses[index]
    }
    
    func hasNext() -> Bool {
        return index + 1 < promptsAndResponses.count
    }
}
