//
//  EnglishIntroController.swift
//  iOS
//
//  Created by Cluster 5 on 7/27/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import MetaWear

class EnglishIntroController: UIViewController {
    
    var device: MBLMetaWear? = nil
    var soundManager: SoundManager!
    
    override func viewDidLoad() {
        loadMapBackground(root: self.view)
    }
}
