//
//  EnglishAnswersController.swift
//  iOS
//
//  Created by Cluster 5 on 7/31/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit

class ChineseAnswersController: UITableViewController {
    @IBOutlet var answersTableView: UITableView!
    
    override func viewDidLoad() {
        let background = UIImageView(frame: self.answersTableView.bounds)
        background.image = #imageLiteral(resourceName: "map2")
        self.answersTableView.backgroundView = background
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: return the number of answers possible, i.e. 3 but that's not good design
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: configure the cell and load information
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: action triggered when a row is selected
    }
}

class AnswerCell: UITableViewCell {
    
}
