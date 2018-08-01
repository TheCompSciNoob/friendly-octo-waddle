//
//  MapBackground.swift
//  iOS
//
//  Created by Cluster 5 on 8/1/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit

func loadMapBackground(root: UIView) {
    let background = UIImageView(frame: root.bounds)
    background.image = #imageLiteral(resourceName: "map2")
    root.insertSubview(background, at: 0)
}
