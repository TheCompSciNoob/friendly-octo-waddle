//
//  engish.swift
//  iOS
//
//  Created by Cluster 5 on 7/28/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

class Stories {
    
    static func chinese_1() -> [PromptAndResponse] {
        return StoryBuilder().createNew().build()
    }
}
