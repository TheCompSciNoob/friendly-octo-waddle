//
//  PaddedLabel.swift
//  iOS
//
//  Created by Cluster 5 on 7/30/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
    }
}
