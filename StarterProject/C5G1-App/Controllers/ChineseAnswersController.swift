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
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var promptText: UILabel!
    
    private var storyManager: StoryManager!
    var device: MBLMetaWear? = nil
    private var answers: [String] = []
    private var hasChosenAnswers: [Bool] = []
    private var answerSelected: IndexPath? = nil {
        didSet {
            submitButton.isEnabled = answerSelected != nil
        }
    }
    
    override func viewDidLoad() {
        //background
        let background = UIImageView(frame: self.answersTableView.bounds)
        background.image = #imageLiteral(resourceName: "map2")
        self.answersTableView.backgroundView = background
        
        //StoryManager as data source
        self.storyManager = StoryManager(promptsAndResponses: Stories.CHINESE_MALL_1, device: device!)
        loadNext()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of answers possible
        return answers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: configure the cell and load information
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChineseAnswerCell", for: indexPath) as! ChineseAnswerCell
        cell.responseTitle.text = "Response \(indexPath.row + 1)"
        cell.responseText.text = answers[indexPath.row]
        if (self.hasChosenAnswers[indexPath.row]) {
            cell.contentView.backgroundColor = .red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.answerSelected = indexPath
        self.storyManager.playCurrentAnswer(indexPath.row)
    }
    
    private func loadNext() {
        self.answerSelected = nil
        if storyManager.hasNext() {
            let (prompt, answers) = storyManager.next()
            self.promptText.text = prompt
            self.answers = answers
            self.hasChosenAnswers = Array(repeating: false, count: answers.count)
            self.answersTableView.reloadData()
        }
    }
    
    @IBAction func onSubmitClicked(_ sender: UIButton) {
        if (storyManager.checkAnswer(answerIndex: (self.answerSelected?.row)!)) {
            loadNext()
        } else {
            //TODO: color the view red
            //TODO: reload data
            print("Incorrect answer selected: \(self.answerSelected?.row)")
            self.hasChosenAnswers[(self.answerSelected?.row)!] = true
            self.answersTableView.reloadData()
        }
        self.answerSelected = nil
    }
    @IBAction func onPromptReplayClicked(_ sender: UIButton) {
        self.storyManager.playCurrentPrompt()
    }
}

class ChineseAnswerCell: UITableViewCell {
    @IBOutlet weak var responseTitle: UILabel!
    @IBOutlet weak var responseText: UILabel!
}
