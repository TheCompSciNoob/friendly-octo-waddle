//
//  MainTestController.swift
//  iOS
//
//  Created by Cluster 5 on 7/26/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import UIKit
import MetaWear

class MainTestController: UIViewController, DeviceConnectedDelegate {
    
    private var device: MBLMetaWear? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        if device != nil {
            print("Devoce ready.")
        }
    }
    
    func onDeviceConnected(device: MBLMetaWear) {
        print("Device connected: \(device.identifier)")
        self.device = device
    }
}
