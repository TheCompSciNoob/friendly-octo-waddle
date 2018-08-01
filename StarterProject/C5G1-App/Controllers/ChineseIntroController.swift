//
//  ChineseIntroController.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear

class ChineseIntroController: UIViewController {
    
    var device: MBLMetaWear? = nil
    
    override func viewDidLoad() {
        loadMapBackground(root: self.view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chineseAnswersController = segue.destination as? ChineseAnswersController {
            chineseAnswersController.device = self.device
        }
    }
}
