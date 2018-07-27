//
//  PromptAndResponse.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

struct PromptAndResponse: Codable {
    let question: TextAndAudio
    let correctResponse: TextAndAudio
    let wrongResponses: [TextAndAudio]
}

struct TextAndAudio: Codable {
    let text: String
    let audioPath: String
}
