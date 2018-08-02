//
//  PromptAndResponse.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

struct PromptAndResponse: Codable {
    var prompt: AudioInfo?
    var correctResponse: AudioInfo?
    var wrongResponses: [AudioInfo?]
}
