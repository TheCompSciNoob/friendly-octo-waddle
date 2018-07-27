//
//  DataUtil.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

//loads json form StoryData
func loadJSON(fileName: String) -> [PromptAndResponse]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        let data = try! Data(contentsOf: url)
        return try? JSONDecoder().decode([PromptAndResponse].self, from: data)
    }
    return nil
}
