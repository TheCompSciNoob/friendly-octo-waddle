//
//  DataUtil.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation

struct DataUtil {
    
    //loads json from StoryData
    static func loadJSON(fileName: String) -> [PromptAndResponse]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            let data = try! Data(contentsOf: url)
            return try? JSONDecoder().decode([PromptAndResponse].self, from: data)
        }
        return nil
    }
    
    //printing an example JSON file of a story line
    static func printDemoStoryJSON() -> String{
        let question1 = AudioInfo(text: "Question1", audioPath: "path", x: 1, y: 1, z: 1)
        let correctResponse1 = AudioInfo(text: "CorrectResponse1", audioPath: "path", x: 1, y: 1, z: 1)
        let wrongResponse1_1 = AudioInfo(text: "WrongResponse1_1", audioPath: "path", x: 1, y: 1, z: 1)
        let wrongResponse1_2 = AudioInfo(text: "WrongResponse1", audioPath: "path", x: 1, y: 1, z: 1)
        
        let question2 = AudioInfo(text: "Question2", audioPath: "path", x: 1, y: 1, z: 1)
        let correctResponse2 = AudioInfo(text: "CorrectResponse2", audioPath: "path", x: 1, y: 1, z: 1)
        let wrongResponse2_1 = AudioInfo(text: "WrongResponse2_1", audioPath: "path", x: 1, y: 1, z: 1)
        let wrongResponse2_2 = AudioInfo(text: "WrongResponse2", audioPath: "path", x: 1, y: 1, z: 1)
        
        let arr = [PromptAndResponse(question: question1, correctResponse: correctResponse1, wrongResponses: [wrongResponse1_1, wrongResponse1_2]), PromptAndResponse(question: question2, correctResponse: correctResponse2, wrongResponses: [wrongResponse2_1, wrongResponse2_2])]
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let output = String(data: try! encoder.encode(arr), encoding: .utf8)!
        print(output)
        return output
    }
}
