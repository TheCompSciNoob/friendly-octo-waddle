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
    private var cocktailEffectManager: CocktailEffectManager? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        if device != nil {
            print("Device ready.")
        }
    }
    
    func onDeviceConnected(device: MBLMetaWear) {
        print("Device connected: \(device.identifier)")
        self.device = device
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainTableViewController = segue.destination as? MainTableViewController {
            mainTableViewController.deviceConnectedDelegate = self
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        device?.disconnectAsync()
    }
    
    @IBAction func startManager(_ sender: UIButton) {
        cocktailEffectManager = CocktailEffectManager(fileNames: ["ZOOM0050_Tr1.WAV", "ZOOM0059_Tr1.WAV"], device: device!)
        cocktailEffectManager?.placeSoundsDefault()
        cocktailEffectManager?.subscribeToDeviceUpdates()
        cocktailEffectManager?.start()
    }
}
