//
//  TexturedButton.swift
//  iOS
//
//  Created by Cluster 5 on 7/31/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit

class TextureButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = self.isEnabled ? UIColor(red: 0.99608, green: 0.92549, blue: 0.58039, alpha: 1.0) : UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 0.75)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isEnabled = true
    }
}
