//
//  EnglishAnswersController.swift
//  iOS
//
//  Created by Cluster 5 on 7/31/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear

class ChineseAnswersController: UITableViewController {
    @IBOutlet var answersTableView: UITableView!
    @IBOutlet weak var prompt: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    private var storyManager: StoryManager!
    private var currentPR: PromptAndResponse? = nil
    private var answers: [AudioInfo] = []
    var device: MBLMetaWear? = nil
    private var answerSelected = -1 {
        didSet {
            submitButton.isEnabled = answerSelected >= 0
        }
    }
    
    override func viewDidLoad() {
        //background
        let background = UIImageView(frame: self.answersTableView.bounds)
        background.image = #imageLiteral(resourceName: "map2")
        self.answersTableView.backgroundView = background
        
        //StoryManager as data source
        self.storyManager = StoryManager(promptsAndResponses: Stories.CHINESE_MALL_1, device: device!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of answers possible
        if let correct = currentPR?.correctResponse {
            answers.append(correct)
        }
        for wrongResponse in currentPR?.wrongResponses ?? [] {
            if let wrong = wrongResponse {
                answers.append(wrong)
            }
        }
        return answers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: configure the cell and load information
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChineseAnswerCell", for: indexPath) as! ChineseAnswerCell
        //temporarily set the location of the correct answer = 0
        cell.responseTitle.text = "Response \(indexPath.row + 1)"
        cell.responseText.text = answers[indexPath.row].text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: action triggered when a row is selected
    }
    
    private func loadNext() {
        self.answerSelected = -1
        if storyManager.hasNext() {
            self.currentPR = storyManager.next()
            self.prompt.text = currentPR?.prompt?.text
            self.answersTableView.reloadData()
        }
    }
    
    @IBAction func onSubmitClicked(_ sender: UIButton) {
        
    }
}

class ChineseAnswerCell: UITableViewCell {
    @IBOutlet weak var responseTitle: UILabel!
    @IBOutlet weak var responseText: UILabel!
}
